import 'package:get/get.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/api/colive_api_client.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/managers/colive_call_engine_manager.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/models/colive_anchor_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/event_bus/colive_event_bus.dart';
import '../widgets/dialogs/colive_dialog_util.dart';
import '../widgets/dialogs/colive_quick_recharge_dialog.dart';
import '../widgets/dialogs/permission/colive_permission_dialog.dart';
import '../models/colive_api_response.dart';
import '../models/colive_call_model.dart';
import '../models/colive_call_settlement_model.dart';
import '../routes/colive_routes.dart';
import 'colive_event_bus_event.dart';

enum ColiveCallType {
  recieved(-1),
  outgoing(0),
  aib(1),
  aia(2);

  final int value;
  const ColiveCallType(this.value);
  static fromValue(int value) =>
      ColiveCallType.values.firstWhere((element) => element.value == value);
}

class ColiveCallInvitationManager {
  ColiveCallInvitationManager._internal();

  static ColiveCallInvitationManager? _instance;
  static ColiveCallInvitationManager get instance =>
      _instance ??= ColiveCallInvitationManager._internal();

  static const _tag = "CallInvitationManager";

  final _apiClient = Get.find<ColiveApiClient>();

  String _getRoomId({required int anchorId}) {
    final userId = ColiveProfileManager.instance.userInfo.id.toString();
    return 'hiChat_${anchorId}_$userId';
  }

  /// send call
  Future<void> sendCallInvitation({
    required ColiveAnchorModel anchor,
  }) async {
    ColiveLogUtil.i(_tag, 'send call invitation');

    final userInfo = ColiveProfileManager.instance.userInfo;
    if (userInfo.diamonds < int.parse(anchor.conversationPrice) &&
        !ColiveProfileManager.instance.hasFreeCallCard) {
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return;
    }
    if (anchor.isRobot) {
      ColiveLoadingUtil.showToast('colive_anchor_busy'.tr);
      return;
    }

    final hasPermissions = await checkHasCallPermissions();
    if (!hasPermissions) return;

    final roomId = _getRoomId(anchorId: anchor.id);
    final userId = userInfo.id.toString();

    await ColiveCallEngineManager.instance.listen(
      notifyUserId: anchor.id.toString(),
      onJoinRoom: (success) {
        ColiveLogUtil.i(_tag, 'onJoinRoom: $success');
        if (!success) {
          ColiveCallEngineManager.instance.exitRoom(roomId);
          ColiveLoadingUtil.dismiss();
          ColiveLoadingUtil.showToast('colive_call_failed'.tr);
          return;
        }
        _inviteRemoteAnchor(anchor: anchor);
      },
    );

    ColiveLoadingUtil.show();
    ColiveCallEngineManager.instance.enterRoom(roomId, userId);
  }

  /// receive call
  Future<void> receiveCallInvitation({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
  }) async {
    ColiveLogUtil.i(_tag, 'receive call invitation ${callType.toString()}');
    if (ColiveAppPreferenceExt.isNoDisturbMode) {
      ColiveLogUtil.w(_tag, 'Local user in NoDisturb Mode');
      apiCallRefuse(callModel: callModel, callType: callType);
      return;
    }

    ColiveEventBus.instance.fire(ColiveCallBeginEvent());
    final roomId = _getRoomId(anchorId: callModel.anchorId);
    Get.toNamed(ColiveRoutes.callWaiting, arguments: {
      'call_model': callModel.copyWith(sessionId: roomId),
      'call_type': callType,
    });
  }

  /// remote anchor refuse call invitation
  Future<void> anchorRefuseCallInvitation() async {
    ColiveLogUtil.i(_tag, 'anchor refuse call invitation');
    ColiveEventBus.instance.fire(ColiveAnchorsRefuseCallEvent());
  }

  /// remote server settlement call finished
  Future<void> serverSettlementCallFinished(
      ColiveCallSettlementModel data) async {
    ColiveLogUtil.i(_tag, 'server settlement call finished');
    ColiveEventBus.instance.fire(ColiveCallSettlementEvent(data));
  }

  Future<void> _inviteRemoteAnchor({required ColiveAnchorModel anchor}) async {
    ColiveApiResponse<ColiveCallModel>? result;
    try {
      result = await apiCreateCall(anchorId: anchor.id, isRobot: false);
    } catch (e) {
      ColiveLogUtil.e(_tag, 'call create failed: ${e.toString()}');
    } finally {
      ColiveLoadingUtil.dismiss();
    }

    final roomId = _getRoomId(anchorId: anchor.id);
    if (result == null || !result.isSuccess || result.data == null) {
      ColiveCallEngineManager.instance.exitRoom(roomId);
      ColiveLoadingUtil.showToast('colive_call_failed'.tr);
      ColiveLogUtil.e(_tag, 'call create failed: ${result.toString()}');
      return;
    }
    final callModel = result.data!;
    if (callModel.isAnchorBusy) {
      ColiveCallEngineManager.instance.exitRoom(roomId);
      ColiveLoadingUtil.showToast('colive_anchor_busy'.tr);
      return;
    } else if (callModel.isAnchorOffline) {
      ColiveCallEngineManager.instance.exitRoom(roomId);
      ColiveLoadingUtil.showToast('colive_anchor_offline'.tr);
      return;
    } else if (callModel.isNotEnoughDiamonds) {
      ColiveCallEngineManager.instance.exitRoom(roomId);
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return;
    }

    Get.toNamed(ColiveRoutes.callWaiting, arguments: {
      'call_model': callModel.copyWith(sessionId: roomId),
      'call_type': ColiveCallType.outgoing,
    });
  }

  Future<bool> checkHasCallPermissions() async {
    /// microphone permission && camera permission
    final isMicroPhoneGranted = await Permission.microphone.isGranted;
    final isCameraGranted = await Permission.camera.isGranted;
    if (isMicroPhoneGranted && isCameraGranted) {
      return true;
    }

    final isMicrophoneDenied =
        await Permission.microphone.request().isPermanentlyDenied;
    final isCameraDenied =
        await Permission.camera.request().isPermanentlyDenied;
    if (isMicrophoneDenied || isCameraDenied) {
      await Get.dialog(
        const ColivePermissionDialog(
          permissionList: [Permission.microphone, Permission.camera],
        ),
      );
      return false;
    }

    return await Permission.microphone.isGranted &&
        await Permission.camera.isGranted;
  }

  // request api call timeout
  Future<ColiveApiResponse<ColiveCallModel>> apiCreateCall(
      {required int anchorId, required bool isRobot}) async {
    final userId = ColiveProfileManager.instance.userInfo.id;
    final isAi = isRobot ? '1' : '0';
    final result =
        await _apiClient.callCreate('$anchorId', '$userId', isAi).response;
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, 'apiCreateCall failed: ${result.toString()}');
    }
    return result;
  }

  // request api call refuse
  Future<void> apiCallRefuse({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
  }) async {
    late ColiveApiResponse result;
    if (callType == ColiveCallType.aia || callType == ColiveCallType.aib) {
      result = await _apiClient
          .callAiRefuse(
            callModel.anchorId.toString(),
            callType.value.toString(),
            '0',
          )
          .retryResult();
    } else {
      result = await _apiClient
          .callRefuse(callModel.conversationId.toString())
          .retryResult();
    }

    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, 'callRefuse failed: ${result.toString()}');
    }
  }

  // request api call timeout
  Future<void> apiCallTimeout({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
  }) async {
    final result = await _apiClient
        .callTimeout(callModel.conversationId.toString())
        .retryResult();
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, 'CallTimeout failed: ${result.toString()}');
    }
  }

  // request api call timeout
  Future<ColiveApiResponse> apiCallAnswer({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
  }) async {
    if (callType == ColiveCallType.aia) {
      final result = await _apiClient.callAiAnswer().retryResult();
      if (!result.isSuccess) {
        ColiveLogUtil.e(_tag, 'callAiAnswer failed: ${result.toString()}');
      }
      return result;
    } else {
      final result = await _apiClient
          .callOn(callModel.conversationId.toString())
          .retryResult();
      if (!result.isSuccess) {
        ColiveLogUtil.e(_tag, 'CallAgree failed: ${result.toString()}');
      }
      return result;
    }
  }

  // request api call settlement
  Future<ColiveApiResponse> apiCallSettlement({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
  }) async {
    final result = await _apiClient
        .callSettlement(callModel.conversationId.toString())
        .retryResult();
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, 'CallSettlement failed: ${result.toString()}');
    }
    return result;
  }

  // request api aia call hangup
  Future<ColiveApiResponse> apiAIACallHangup({
    required ColiveCallModel callModel,
    required ColiveCallType callType,
    required bool isPlayFinished,
  }) async {
    final finish = isPlayFinished ? '2' : '1';
    final result = await _apiClient
        .callAiHangup(callModel.anchorId.toString(), callModel.url, finish)
        .retryResult();
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, 'CallSettlement failed: ${result.toString()}');
    }
    return result;
  }
}
