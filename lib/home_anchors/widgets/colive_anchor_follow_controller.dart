import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_follow_model.dart';
import '../../services/routes/colive_routes.dart';

class ColiveAnchorFollowController extends ColiveBaseController {
  final anchorList = <ColiveAnchorModel>[].obs;
  final isNoData = false.obs;
  final isLoadFailed = false.obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  void setupListener() {
    subsriptions.add(ColiveEventBus.instance
        .on<ColiveFollowRefreshEvent>()
        .listen((event) {
      onRefresh();
    }));
    subsriptions.add(ColiveEventBus.instance
        .on<ColiveAnchorStatusChangedEvent>()
        .listen((event) {
      final newList = List.of(anchorList);
      final index =
          newList.indexWhere((element) => element.id == event.anchorId);
      if (index >= 0) {
        if (event.online == 1) {
          final anchor = newList.removeAt(index);
          anchor.online = event.online;
          newList.insert(0, anchor);
        } else {
          newList[index].online = event.online;
          newList.sort((a, b) => a.online.compareTo(b.online));
        }
        anchorList.value = newList;
      }
    }));
  }

  void onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _fetchAnchorList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        isLoadFailed.value = anchorList.isEmpty;
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      anchorList.value = data.map((e) => e.toAnchorModel).toList();
      isNoData.value = anchorList.isEmpty;
      isLoadFailed.value = false;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      isLoadFailed.value = anchorList.isEmpty;
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoadMore() async {
    try {
      _currentPage++;
      final result = await _fetchAnchorList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      anchorList.addAll(data.map((e) => e.toAnchorModel).toList());
      refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
  }

  Future<ColiveApiResponse<List<ColiveFollowModel>>> _fetchAnchorList({
    required int page,
    required int size,
  }) async {
    final anchorRes = await apiClient.fetchFollowList(
      '$page',
      '$size',
    );
    if (anchorRes.isSuccess && anchorRes.data != null) {
      _saveAnchorList(anchorRes.data!);
    }
    return anchorRes;
  }

  Future<void> _saveAnchorList(List<ColiveFollowModel> list) async {
    for (var element in list) {
      final anchor = await database.anchorDao.findAnchorById(element.followId);
      if (anchor == null) {
        database.anchorDao.insertAnchor(element.toAnchorModel);
      }
    }
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
