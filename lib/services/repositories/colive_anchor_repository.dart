import 'dart:math';

import 'package:get/get.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../common/logger/colive_log_util.dart';
import '../../common/utils/colive_loading_util.dart';
import '../api/colive_api_client.dart';
import '../database/colive_database.dart';
import '../managers/colive_event_bus_event.dart';
import '../models/colive_anchor_model.dart';
import '../routes/colive_routes.dart';

class ColiveAnchorRepository {
  static const _tag = "AnchorRepository";
  final ColiveApiClient _apiClient = Get.find<ColiveApiClient>();
  final ColiveDatabase _database = Get.find<ColiveDatabase>();

  Future<ColiveAnchorModel?> fetchAnchorInfo({
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

  Future<ColiveAnchorModel?> _fetchAnchorInfo(
    bool isRobot,
    int anchorId,
    bool fetchVideos,
  ) async {
    ColiveAnchorModel? anchor;
    final cacheAnchor = await _database.anchorDao.findAnchorById(anchorId);
    if (isRobot) {
      List<ColiveAnchorModelVideo>? videoList;
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
        ColiveLogUtil.e(_tag, 'fetchRobotAnchorInfo error: ${result.msg}');
      }
    } else {
      List<ColiveAnchorModelVideo>? videoList;
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
        ColiveLogUtil.e(_tag, 'fetchAnchorInfo error: ${result.msg}');
      }
    }
    return anchor;
  }

  Future<ColiveAnchorModel?> requestFollow(
      {required ColiveAnchorModel anchor}) async {
    ColiveAnchorModel? newAnchor;
    if (anchor.isLike) {
      ColiveLoadingUtil.show();
      final result =
          await _apiClient.cancelFollow(anchor.id.toString()).response;
      ColiveLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(
          isLike: false,
          like: max(anchor.like - 1, 0),
        );
        _database.anchorDao.updateAnchor(newAnchor);
        ColiveEventBus.instance.fire(ColiveFollowRefreshEvent());
        ColiveLoadingUtil.showToast('colive_cancel_follow_tips'.tr);
      } else {
        ColiveLoadingUtil.showToast(result.msg);
      }
    } else {
      ColiveLoadingUtil.show();
      final result = await _apiClient.addFollow(anchor.id.toString()).response;
      ColiveLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(
          isLike: true,
          like: anchor.like + 1,
        );
        _database.anchorDao.updateAnchor(newAnchor);
        ColiveEventBus.instance.fire(ColiveFollowRefreshEvent());
        ColiveLoadingUtil.showToast('colive_add_follow_tips'.tr);
      } else {
        ColiveLoadingUtil.showToast(result.msg);
      }
    }
    return newAnchor;
  }

  Future<ColiveAnchorModel?> requestBlock(
      {required ColiveAnchorModel anchor}) async {
    ColiveAnchorModel? newAnchor;
    if (anchor.isToBlock) {
      ColiveLoadingUtil.show();
      final result = await _apiClient
          .cancelBlock(anchor.id.toString(), anchor.robot.toString())
          .response;
      await ColiveChatManager.instance
          .updateBlock(anchorId: anchor.sessionId, isBlock: false);
      ColiveLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(isBlock: false);
        _database.anchorDao.updateAnchor(newAnchor);
        ColiveLoadingUtil.showToast('colive_cancel_block_tips'.tr);
        ColiveProfileManager.instance.fetchProfile();
      } else {
        ColiveLoadingUtil.showToast(result.msg);
      }
    } else {
      ColiveLoadingUtil.show();
      final result = await _apiClient
          .addBlock(anchor.id.toString(), anchor.robot.toString())
          .response;
      await ColiveChatManager.instance
          .updateBlock(anchorId: anchor.sessionId, isBlock: true);
      ColiveLoadingUtil.dismiss();
      if (result.isSuccess) {
        newAnchor = anchor.copyWith(isBlock: true);
        _database.anchorDao.updateAnchor(newAnchor);
        ColiveLoadingUtil.showToast('colive_add_block_tips'.tr);
        Get.until((route) => route.settings.name == ColiveRoutes.home);
        ColiveProfileManager.instance.fetchProfile();
      } else {
        ColiveLoadingUtil.showToast(result.msg);
      }
    }
    return newAnchor;
  }
}
