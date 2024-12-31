import 'dart:math';

import 'package:get/get.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/services/managers/vochat_chat_manager.dart';

import '../../login/managers/vochat_profile_manager.dart';
import '../../common/api/vochat_api_client.dart';
import '../../common/event_bus/vochat_event_bus.dart';
import '../../common/logger/vochat_log_util.dart';
import '../../common/utils/vochat_loading_util.dart';
import '../../common/database/vochat_database.dart';
import '../../common/event_bus/vochat_event_bus_event.dart';
import '../models/vochat_anchor_model.dart';
import '../../common/routes/vochat_routes.dart';

class VochatAnchorRepository {
  static const _tag = "AnchorRepository";
  final VochatApiClient _apiClient = Get.find<VochatApiClient>();
  final VochatDatabase _database = Get.find<VochatDatabase>();

  Future<VochatAnchorModel?> fetchAnchorInfo({
    required bool isRobot,
    required int anchorId,
    required bool ignoreCache,
    required bool fetchVideos,
  }) async {
    if (ignoreCache) {
      return await _fetchAnchorInfo(isRobot, anchorId, fetchVideos);
    }
    var anchor = await _database.anchorDao.findAnchorById(anchorId);
    anchor ??= await _fetchAnchorInfo(isRobot, anchorId, fetchVideos);
    return anchor;
  }

  Future<VochatAnchorModel?> _fetchAnchorInfo(
    bool isRobot,
    int anchorId,
    bool fetchVideos,
  ) async {
    VochatAnchorModel? anchor;
    final cacheAnchor = await _database.anchorDao.findAnchorById(anchorId);
    if (isRobot) {
      List<VochatAnchorModelVideo>? videoList;
      if (fetchVideos) {
        final result =
            await _apiClient.fetchRobotAnchorVideoList('$anchorId').response;
        if (result.isSuccess) {
          videoList = result.data ?? [];
        }
      }
      final result =
          await _apiClient.fetchRobotAnchorInfo('$anchorId').response;
      if (result.isSuccess && result.data != null) {
        final tmpAnchor = result.data!.toAnchorModel;
        anchor = tmpAnchor.copyWith(
          robot: 1,
          videos: videoList,
          isBlock: cacheAnchor?.isToBlock ?? false,
          like: max(cacheAnchor?.like ?? 0, tmpAnchor.like),
        );
        _database.anchorDao.insertAnchor(anchor);
      } else {
        VochatLogUtil.e(_tag, 'fetchRobotAnchorInfo error: ${result.msg}');
      }
    } else {
      List<VochatAnchorModelVideo>? videoList;
      if (fetchVideos) {
        final result = await _apiClient
            .fetchAnchorVideoList('$anchorId', '1', '10')
            .response;
        if (result.isSuccess) {
          videoList = result.data ?? [];
        }
      }
      final result = await _apiClient.fetchAnchorInfo('$anchorId').response;
      if (result.isSuccess && result.data != null) {
        final tmpAnchor = result.data!.toAnchorModel;
        anchor = tmpAnchor.copyWith(
          robot: 0,
          videos: videoList,
          isBlock: cacheAnchor?.isToBlock ?? false,
          like: max(cacheAnchor?.like ?? 0, tmpAnchor.like),
        );
        _database.anchorDao.insertAnchor(anchor);
      } else {
        VochatLogUtil.e(_tag, 'fetchAnchorInfo error: ${result.msg}');
      }
    }
    return anchor;
  }

  Future<VochatAnchorModel?> requestFollow(
      {required VochatAnchorModel anchor}) async {
    VochatAnchorModel? newAnchor;
    if (anchor.isLike) {
      VochatLoadingUtil.show();
      final result =
          await _apiClient.cancelFollow(anchor.id.toString()).response;
      VochatLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(
          isLike: false,
          like: max(anchor.like - 1, 0),
        );
        _database.anchorDao.updateAnchor(newAnchor);
        VochatEventBus.instance.fire(VochatFollowRefreshEvent());
        VochatLoadingUtil.showToast('vochat_cancel_follow_tips'.tr);
      } else {
        VochatLoadingUtil.showToast(result.msg);
      }
    } else {
      VochatLoadingUtil.show();
      final result = await _apiClient.addFollow(anchor.id.toString()).response;
      VochatLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(
          isLike: true,
          like: anchor.like + 1,
        );
        _database.anchorDao.updateAnchor(newAnchor);
        VochatEventBus.instance.fire(VochatFollowRefreshEvent());
        VochatLoadingUtil.showToast('vochat_add_follow_tips'.tr);
      } else {
        VochatLoadingUtil.showToast(result.msg);
      }
    }
    return newAnchor;
  }

  Future<VochatAnchorModel?> requestBlock(
      {required VochatAnchorModel anchor}) async {
    VochatAnchorModel? newAnchor;
    if (anchor.isToBlock) {
      VochatLoadingUtil.show();
      final result = await _apiClient
          .cancelBlock(anchor.id.toString(), anchor.robot.toString())
          .response;
      await VochatChatManager.instance
          .updateBlock(anchorId: anchor.sessionId, isBlock: false);
      VochatLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(isBlock: false);
        _database.anchorDao.updateAnchor(newAnchor);
        VochatLoadingUtil.showToast('vochat_cancel_block_tips'.tr);
        VochatProfileManager.instance.fetchProfile();
      } else {
        VochatLoadingUtil.showToast(result.msg);
      }
    } else {
      VochatLoadingUtil.show();
      final result = await _apiClient
          .addBlock(anchor.id.toString(), anchor.robot.toString())
          .response;
      await VochatChatManager.instance
          .updateBlock(anchorId: anchor.sessionId, isBlock: true);
      VochatLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(isBlock: true);
        _database.anchorDao.updateAnchor(newAnchor);
        VochatLoadingUtil.showToast('vochat_add_block_tips'.tr);
        Get.until((route) => route.settings.name == VochatRoutes.tabs);
        VochatProfileManager.instance.fetchProfile();
      } else {
        VochatLoadingUtil.showToast(result.msg);
      }
    }
    return newAnchor;
  }
}
