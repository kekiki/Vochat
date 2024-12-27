import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/utils/colive_keyboard_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/models/colive_search_history_model.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../services/database/colive_database.dart';
import '../services/managers/colive_call_invitation_manager.dart';
import '../services/models/colive_anchor_model.dart';
import '../services/routes/colive_routes.dart';
import 'colive_search_state.dart';

class ColiveSearchController extends ColiveBaseController {
  final state = ColiveSearchState();
  final editingController = TextEditingController();

  @override
  void setupListener() {
    subsriptions
        .add(database.searchHistoryDao.getHistoryListByStream().listen((event) {
      if (event == null) {
        state.historyListObs.value = RxList.empty();
      } else {
        state.historyListObs.value = event.map((e) => e.history).toList();
      }
    }));
    editingController.addListener(_editControllerListener);
  }

  @override
  void onClose() {
    editingController.removeListener(_editControllerListener);
    editingController.dispose();
    super.onClose();
  }

  void _editControllerListener() {
    state.statusObs.value = ColiveSearchStatus.init;
  }

  void onTapSearch(String text) async {
    final keyword = text.trim();
    if (keyword.isEmpty) {
      state.statusObs.value = ColiveSearchStatus.init;
      return;
    }
    editingController.text = keyword;
    ColiveKeyboardUtil.hideKeyboard(Get.context);
    ColiveLoadingUtil.show();
    database.searchHistoryDao.insertHistory(
      ColiveSearchHistoryModel(
        keyword,
        DateTime.now().microsecondsSinceEpoch,
      ),
    );
    final result = await apiClient.searchAnchorList(keyword);
    ColiveLoadingUtil.dismiss();
    final data = result.data;
    if (!result.isSuccess || data == null) {
      state.statusObs.value = ColiveSearchStatus.failed;
      return;
    }
    final List list = result.data!['info'] ?? [];
    state.anchorListObs.value =
        list.map((e) => ColiveAnchorModel.fromJson(e)).toList();
    if (state.anchorListObs.isEmpty) {
      state.statusObs.value = ColiveSearchStatus.empty;
      return;
    }
    state.statusObs.value = ColiveSearchStatus.list;
    _saveAnchorList(state.anchorListObs);
  }

  Future<void> _saveAnchorList(List<ColiveAnchorModel> list) async {
    final database = Get.find<ColiveDatabase>();
    for (var element in list) {
      final anchor = await database.anchorDao.findAnchorById(element.id);
      if (anchor != null) {
        database.anchorDao.updateAnchor(anchor.copyWith(
          area: element.area,
          avatar: element.avatar,
          birthday: element.birthday,
          channel: element.channel,
          conversationPrice: element.conversationPrice,
          country: element.country,
          countryCurrency: element.countryCurrency,
          countryIcon: element.countryIcon,
          diamonds: element.diamonds,
          disturb: element.disturb,
          gender: element.gender,
          nickname: element.nickname,
          online: element.online,
          signature: element.signature,
          star: element.star,
        ));
      } else {
        database.anchorDao.insertAnchor(element);
      }
    }
  }

  void onTapHistoryClear() {
    database.searchHistoryDao.clear();
    state.historyListObs.value = RxList.empty();
  }

  void onTapAnchor(ColiveAnchorModel anchor) {
    Get.toNamed(ColiveRoutes.anchorDetail, arguments: anchor);
  }

  void onTapCall(ColiveAnchorModel anchor) {
    ColiveCallInvitationManager.instance.sendCallInvitation(anchor: anchor);
  }

  void onTapChat(ColiveAnchorModel anchor) {
    Get.toNamed(ColiveRoutes.chat, arguments: anchor.sessionId);
  }
}
