import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_moment_item_model.dart';

class ColiveMoreMomentController extends ColiveBaseController {
  late ColiveAnchorModel anchorInfo;
  final momentListObs = <ColiveMomentItemModel>[].obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void onInit() {
    anchorInfo = Get.arguments;
    super.onInit();
    database.momentDao.findMomentListByAnchorId(anchorInfo.id).then(
          (value) => momentListObs.value = value,
        );
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
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
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      momentListObs.value = data;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
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
      momentListObs.addAll(data);
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
    final anchorId = anchorInfo.id;
    final result =
        await apiClient.fetchAnchorMomentList('$anchorId', '$page', '$size');
    return result;
  }
}
