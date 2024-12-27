import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_moment_item_model.dart';

class ColiveMomentHotController extends ColiveBaseController {
  final momentList = <ColiveMomentItemModel>[].obs;
  final isNoData = false.obs;
  final isLoadFailed = false.obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _fetchMomentList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        isLoadFailed.value = momentList.isEmpty;
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      isLoadFailed.value = false;
      momentList.value = data;
      isNoData.value = momentList.isEmpty;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      isLoadFailed.value = momentList.isEmpty;
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoadMore() async {
    try {
      _currentPage++;
      final result = await _fetchMomentList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      momentList.addAll(data);
      refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
  }

  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> _fetchMomentList({
    required int page,
    required int size,
  }) async {
    final user = ColiveProfileManager.instance.userInfo;
    final result = await apiClient.fetchMomentList(
      user.country,
      '$page',
      '$size',
    );
    if (result.isSuccess && result.data != null) {
      _saveMomentList(result.data!);
    }
    return result;
  }

  Future<void> _saveMomentList(List<ColiveMomentItemModel> list) async {
    for (var element in list) {
      final anchor = await database.anchorDao.findAnchorById(element.uid);
      if (anchor == null) {
        database.anchorDao.insertAnchor(element.toAnchorModel);
      }
      final moment = await database.momentDao.findMomentById(element.id);
      if (moment == null) {
        database.momentDao.insertMoment(element);
      } else {
        database.momentDao.insertMoment(element.copyWith(
          isLike: moment.isLike,
          likeNum: max(moment.likeNum, element.likeNum),
        ));
      }
    }
  }
}