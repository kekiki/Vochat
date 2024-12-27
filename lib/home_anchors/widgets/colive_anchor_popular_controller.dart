import 'dart:async';

import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../services/extensions/colive_preference_ext.dart';
import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_area_model.dart';
import '../../services/models/colive_banner_model.dart';
import '../../services/routes/colive_routes.dart';

class ColiveAnchorPopularController extends ColiveBaseController {
  final String _globalArea = 'Globle';

  final bannerList = <ColiveBannerModel>[].obs;
  final areaList = <ColiveAreaModel>[].obs;
  final anchorList = <ColiveAnchorModel>[].obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 20;

  final isNoData = false.obs;
  final isLoadFailed = false.obs;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  void setupListener() {
    subsriptions.add(
        ColiveEventBus.instance.on<ColiveAnchorsRefreshEvent>().listen((event) {
      onRefresh();
    }));
    subsriptions.add(ColiveEventBus.instance
        .on<ColiveCurrentAreaChangedEvent>()
        .listen((event) {
      _onCurrentAreaChanged();
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

  void onTapSearch() {
    Get.toNamed(ColiveRoutes.search);
  }

  Future<void> _onCurrentAreaChanged() async {
    ColiveLoadingUtil.show();
    await onRefresh();
    ColiveLoadingUtil.dismiss();
  }

  Future<void> onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _fetchAnchorList(
        isRefresh: true,
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        isLoadFailed.value = anchorList.isEmpty;
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      anchorList.value = data;
      isLoadFailed.value = false;
      isNoData.value = anchorList.isEmpty;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      isLoadFailed.value = anchorList.isEmpty;
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  Future<void> onLoadMore() async {
    try {
      _currentPage++;
      final result = await _fetchAnchorList(
        isRefresh: false,
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      anchorList.addAll(data);
      refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
  }

  Future<ColiveApiResponse<List<ColiveAnchorModel>>> _fetchAnchorList({
    required bool isRefresh,
    required int page,
    required int size,
  }) async {
    if (isRefresh) {
      final bannerRes = await apiClient.fetchBannerList().response;
      if (bannerRes.isSuccess && bannerRes.data != null) {
        bannerList.value = bannerRes.data!;
      }

      final areaRes = await apiClient.fetchAreaList().response;
      if (areaRes.isSuccess && areaRes.data != null) {
        ColiveAppPreferenceExt.areList =
            areaRes.data!.map((e) => e.area).toList();
        areaList.value = areaRes.data!;
      }

      final area = areaList.isNotEmpty ? areaList.first.area : _globalArea;
      if (ColiveAppPreferenceExt.currentArea.isEmpty) {
        ColiveAppPreferenceExt.currentArea = area;
      }
    }

    final anchorRes = await apiClient
        .fetchAnchorList(
          ColiveAppPreferenceExt.currentArea,
          '$page',
          '$size',
        )
        .response;
    if (anchorRes.isSuccess && anchorRes.data != null) {
      _saveAnchorList(anchorRes.data!);
    }
    return anchorRes;
  }

  Future<void> _saveAnchorList(List<ColiveAnchorModel> list) async {
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

  void onTapBanner(ColiveBannerModel banner) {
    if (banner.isLink) {
      Get.toNamed(ColiveRoutes.web, arguments: {'url': banner.link});
    } else {
      if (banner.isPay) {
        Get.toNamed(ColiveRoutes.store);
      } else {
        Get.toNamed(ColiveRoutes.vip);
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
