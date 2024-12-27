import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_login_model.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/widgets/colive_base_controller.dart';

class ColiveMoreVideoController extends ColiveBaseController {
  late ColiveAnchorModel anchorInfo;
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
  final videoListObs = <ColiveAnchorModelVideo>[].obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void onInit() {
    anchorInfo = Get.arguments;
    videoListObs.value = anchorInfo.videos;
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((user) {
      profileObs.value = user;
    }));
  }

  void onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _fetchVideoList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      videoListObs.value = data;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoadMore() async {
    try {
      _currentPage++;
      final result = await _fetchVideoList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      videoListObs.addAll(data);
      refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
  }

  Future<ColiveApiResponse<List<ColiveAnchorModelVideo>>> _fetchVideoList({
    required int page,
    required int size,
  }) async {
    final anchorId = anchorInfo.id;
    late ColiveApiResponse<List<ColiveAnchorModelVideo>> result;
    if (anchorInfo.isRobot) {
      result = await apiClient.fetchRobotAnchorVideoList('$anchorId');
    } else {
      result =
          await apiClient.fetchAnchorVideoList('$anchorId', '$page', '$size');
    }
    return result;
  }

  void onTapVideo(ColiveAnchorModelVideo video) {
    final videos = anchorInfo.videos;
    final index = videos.indexOf(video);
    Get.toNamed(ColiveRoutes.anchorVideos, arguments: {
      'index': index,
      'list': videos,
    });
  }
}
