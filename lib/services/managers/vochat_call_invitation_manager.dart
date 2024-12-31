import 'package:get/get.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/services/managers/vochat_call_engine_manager.dart';
import 'package:vochat/services/models/vochat_anchor_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../login/managers/vochat_profile_manager.dart';
import '../../common/api/vochat_api_client.dart';
import '../../common/event_bus/vochat_event_bus.dart';
import '../../common/widgets/dialogs/permission/vochat_permission_dialog.dart';
import '../../common/widgets/dialogs/vochat_dialog_util.dart';
import '../../common/widgets/dialogs/vochat_quick_recharge_dialog.dart';
import '../models/vochat_api_response.dart';
import '../models/vochat_call_model.dart';
import '../models/vochat_call_settlement_model.dart';
import '../../common/event_bus/vochat_event_bus_event.dart';

enum VochatCallType {
  recieved(-1),
  outgoing(0),
  aib(1),
  aia(2);

  final int value;
  const VochatCallType(this.value);
  static fromValue(int value) =>
      VochatCallType.values.firstWhere((element) => element.value == value);
}

class VochatCallInvitationManager {
  VochatCallInvitationManager._internal();

  static VochatCallInvitationManager? _instance;
  static VochatCallInvitationManager get instance =>
      _instance ??= VochatCallInvitationManager._internal();

  static const _tag = "CallInvitationManager";

  final _apiClient = Get.find<VochatApiClient>();

  String _getRoomId({required int anchorId}) {
    final userId = VochatProfileManager.instance.userInfo.id.toString();
    return 'hiChat_${anchorId}_$userId';
  }

  /// send call
  Future<void> sendCallInvitation({
    required VochatAnchorModel anchor,
  }) async {
    VochatLogUtil.i(_tag, 'send call invitation');

    final userInfo = VochatProfileManager.instance.userInfo;
    if (userInfo.mizuan < int.parse(anchor.conversationPrice)) {
      VochatDialogUtil.showDialog(
        const VochatQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return;
    }
    if (anchor.isRobot) {
      VochatLoadingUtil.showToast('vochat_anchor_busy'.tr);
      return;
    }

    final hasPermissions = await checkHasCallPermissions();
    if (!hasPermissions) return;

    final roomId = _getRoomId(anchorId: anchor.id);
    final userId = userInfo.id.toString();

    await VochatCallEngineManager.instance.listen(
      notifyUserId: anchor.id.toString(),
      onJoinRoom: (success) {
        VochatLogUtil.i(_tag, 'onJoinRoom: $success');
        if (!success) {
          VochatCallEngineManager.instance.exitRoom(roomId);
          VochatLoadingUtil.dismiss();
          VochatLoadingUtil.showToast('vochat_call_failed'.tr);
          return;
        }
        _inviteRemoteAnchor(anchor: anchor);
      },
    );

    VochatLoadingUtil.show();
    VochatCallEngineManager.instance.enterRoom(roomId, userId);
  }

  /// receive call
  Future<void> receiveCallInvitation({
    required VochatCallModel callModel,
    required VochatCallType callType,
  }) async {
    // VochatLogUtil.i(_tag, 'receive call invitation ${callType.toString()}');
    // if (VochatPreference.isNoDisturbMode) {
    //   VochatLogUtil.w(_tag, 'Local user in NoDisturb Mode');
    //   apiCallRefuse(callModel: callModel, callType: callType);
    //   return;
    // }

    // VochatEventBus.instance.fire(VochatCallBeginEvent());
    // final roomId = _getRoomId(anchorId: callModel.anchorId);
    // Get.toNamed(VochatRoutes.callWaiting, arguments: {
    //   'call_model': callModel.copyWith(sessionId: roomId),
    //   'call_type': callType,
    // });
  }

  /// remote anchor refuse call invitation
  Future<void> anchorRefuseCallInvitation() async {
    VochatLogUtil.i(_tag, 'anchor refuse call invitation');
    VochatEventBus.instance.fire(VochatAnchorsRefuseCallEvent());
  }

  /// remote server settlement call finished
  Future<void> serverSettlementCallFinished(
      VochatCallSettlementModel data) async {
    VochatLogUtil.i(_tag, 'server settlement call finished');
    VochatEventBus.instance.fire(VochatCallSettlementEvent(data));
  }

  Future<void> _inviteRemoteAnchor({required VochatAnchorModel anchor}) async {
    VochatApiResponse<VochatCallModel>? result;
    try {
      result = await apiCreateCall(anchorId: anchor.id, isRobot: false);
    } catch (e) {
      VochatLogUtil.e(_tag, 'call create failed: ${e.toString()}');
    } finally {
      VochatLoadingUtil.dismiss();
    }

    final roomId = _getRoomId(anchorId: anchor.id);
    if (result == null || !result.isSuccess || result.data == null) {
      VochatCallEngineManager.instance.exitRoom(roomId);
      VochatLoadingUtil.showToast('vochat_call_failed'.tr);
      VochatLogUtil.e(_tag, 'call create failed: ${result.toString()}');
      return;
    }
    final callModel = result.data!;
    if (callModel.isAnchorBusy) {
      VochatCallEngineManager.instance.exitRoom(roomId);
      VochatLoadingUtil.showToast('vochat_anchor_busy'.tr);
      return;
    } else if (callModel.isAnchorOffline) {
      VochatCallEngineManager.instance.exitRoom(roomId);
      VochatLoadingUtil.showToast('vochat_anchor_offline'.tr);
      return;
    } else if (callModel.isNotEnoughDiamonds) {
      VochatCallEngineManager.instance.exitRoom(roomId);
      VochatDialogUtil.showDialog(
        const VochatQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return;
    }

    // Get.toNamed(VochatRoutes.callWaiting, arguments: {
    //   'call_model': callModel.copyWith(sessionId: roomId),
    //   'call_type': VochatCallType.outgoing,
    // });
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
        const VochatPermissionDialog(
          permissionList: [Permission.microphone, Permission.camera],
        ),
      );
      return false;
    }

    return await Permission.microphone.isGranted &&
        await Permission.camera.isGranted;
  }

  // request api call timeout
  Future<VochatApiResponse<VochatCallModel>> apiCreateCall(
      {required int anchorId, required bool isRobot}) async {
    final userId = VochatProfileManager.instance.userInfo.id;
    final isAi = isRobot ? '1' : '0';
    final result =
        await _apiClient.callCreate('$anchorId', '$userId', isAi).response;
    if (!result.isSuccess) {
      VochatLogUtil.e(_tag, 'apiCreateCall failed: ${result.toString()}');
    }
    return result;
  }

  // request api call refuse
  Future<void> apiCallRefuse({
    required VochatCallModel callModel,
    required VochatCallType callType,
  }) async {
    late VochatApiResponse result;
    if (callType == VochatCallType.aia || callType == VochatCallType.aib) {
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
      VochatLogUtil.e(_tag, 'callRefuse failed: ${result.toString()}');
    }
  }

  // request api call timeout
  Future<void> apiCallTimeout({
    required VochatCallModel callModel,
    required VochatCallType callType,
  }) async {
    final result = await _apiClient
        .callTimeout(callModel.conversationId.toString())
        .retryResult();
    if (!result.isSuccess) {
      VochatLogUtil.e(_tag, 'CallTimeout failed: ${result.toString()}');
    }
  }

  // request api call timeout
  Future<VochatApiResponse> apiCallAnswer({
    required VochatCallModel callModel,
    required VochatCallType callType,
  }) async {
    if (callType == VochatCallType.aia) {
      final result = await _apiClient.callAiAnswer().retryResult();
      if (!result.isSuccess) {
        VochatLogUtil.e(_tag, 'callAiAnswer failed: ${result.toString()}');
      }
      return result;
    } else {
      final result = await _apiClient
          .callOn(callModel.conversationId.toString())
          .retryResult();
      if (!result.isSuccess) {
        VochatLogUtil.e(_tag, 'CallAgree failed: ${result.toString()}');
      }
      return result;
    }
  }

  // request api call settlement
  Future<VochatApiResponse> apiCallSettlement({
    required VochatCallModel callModel,
    required VochatCallType callType,
  }) async {
    final result = await _apiClient
        .callSettlement(callModel.conversationId.toString())
        .retryResult();
    if (!result.isSuccess) {
      VochatLogUtil.e(_tag, 'CallSettlement failed: ${result.toString()}');
    }
    return result;
  }

  // request api aia call hangup
  Future<VochatApiResponse> apiAIACallHangup({
    required VochatCallModel callModel,
    required VochatCallType callType,
    required bool isPlayFinished,
  }) async {
    final finish = isPlayFinished ? '2' : '1';
    final result = await _apiClient
        .callAiHangup(callModel.anchorId.toString(), callModel.url, finish)
        .retryResult();
    if (!result.isSuccess) {
      VochatLogUtil.e(_tag, 'CallSettlement failed: ${result.toString()}');
    }
    return result;
  }
}
