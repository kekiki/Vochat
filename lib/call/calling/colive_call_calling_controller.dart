import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/event_bus/colive_event_bus.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/widgets/dialogs/gift/colive_gift_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/managers/colive_call_engine_manager.dart';
import 'package:colive/services/managers/colive_socket_manager.dart';
import 'package:wakelock/wakelock.dart';

import '../../common/logger/colive_log_util.dart';
import '../../common/utils/colive_format_util.dart';
import '../../services/widgets/dialogs/colive_quick_recharge_dialog.dart';
import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_call_settlement_model.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/widgets/colive_base_controller.dart';
import '../../services/widgets/dialogs/colive_confirm_dialog.dart';
import 'colive_call_calling_state.dart';
import 'widgets/colive_calling_placeholder.dart';

class ColiveCallCallingController extends ColiveBaseController {
  final state = ColiveCallCallingState();

  final _tag = 'Video Calling';
  Timer? _chatTimer;
  int _callingSeconds = 1;

  bool isCallEnd = false;
  bool isExitRoom = false;

  Widget? _localPreviewWidget;
  Widget? _remotePreviewWidget;

  bool _isRemoteCameraEnable = false;

  final StreamController<Widget> _smallScreenWidgetStreamController =
      StreamController();
  final StreamController<Widget> _fullScreenWidgetStreamController =
      StreamController();

  Stream<Widget> get smallScreenWidgetStream =>
      _smallScreenWidgetStreamController.stream;

  Stream<Widget> get fullScreenWidgetStream =>
      _fullScreenWidgetStreamController.stream;

  StreamController<Widget> get _localController => state.isLocalSmallPreview
      ? _smallScreenWidgetStreamController
      : _fullScreenWidgetStreamController;

  StreamController<Widget> get _remoteController => state.isLocalSmallPreview
      ? _fullScreenWidgetStreamController
      : _smallScreenWidgetStreamController;

  Widget get initFullScreenPlaceholder => ColiveCallingPlaceholder(
      avatar: state.callModel.anchorAvatar, fullScreen: true, isSelf: false);

  Widget get initSmallScreenPlaceholder => ColiveCallingPlaceholder(
      avatar: state.profileObs.value.avatar, fullScreen: false, isSelf: true);

  @override
  void onInit() {
    final arguments = Get.arguments;
    state.callModel = arguments['call_model'];
    state.callType = arguments['call_type'];
    super.onInit();

    Wakelock.enable();
    _startCallingTimer();
    _startPushStream();
  }

  @override
  void onClose() {
    _chatTimer?.cancel();
    _smallScreenWidgetStreamController.close();
    _fullScreenWidgetStreamController.close();
    _localPreviewWidget = null;
    _remotePreviewWidget = null;
    Wakelock.disable();
    super.onClose();
  }

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((userInfo) {
      state.profileObs.value = userInfo;
    }));

    subsriptions.add(
        ColiveEventBus.instance.on<ColiveCallSettlementEvent>().listen((event) {
      if (state.callType != ColiveCallType.aia) {
        _onSettlementCall(event.data);
      }
    }));

    ColiveCallEngineManager.instance.listen(
      notifyUserId: state.callModel.anchorId.toString(),
      onFinishCall: _onFinishCall,
      onRemoteUserLeave: _onRemoteUserLeave,
      onStreamAdd: _onStreamAdd,
      onRemoteCameraStateUpdate: _onRemoteCameraStateUpdate,
    );
  }

  void _startCallingTimer() {
    if (state.callType == ColiveCallType.aia) return;
    ColiveLogUtil.d(_tag, "_startCallingTimer");
    _chatTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.callingDurationObs.value = ColiveFormatUtil.durationToTime(
        _callingSeconds,
        isShowHour: false,
      );
      _callingSeconds += 1;
    });
  }

  void _sendStartCallingMessage() {
    if (state.callType == ColiveCallType.recieved) {
      final conversationId = state.callModel.conversationId.toString();
      ColiveSocketManager.instance
          .sendStartCallingMessage(conversationId: conversationId);
    }
  }

  Future<void> _startPushStream() async {
    ColiveCallEngineManager.instance.setupVideoConfig();

    final localWidget =
        await ColiveCallEngineManager.instance.startPreview(true);
    if (localWidget != null) {
      _smallScreenWidgetStreamController.add(localWidget);
      _localPreviewWidget = localWidget;
    }

    if (state.callType == ColiveCallType.recieved) {
      final streamId = state.profileObs.value.id.toString();
      ColiveCallEngineManager.instance.startPushStream(streamId);
    } else if (state.callType == ColiveCallType.aia) {
      ColiveCallEngineManager.instance.muteSpeaker(true);
      state.isSpeakerObs.value = false;
    }
  }

  void _onStreamAdd(String streamId) async {
    final remoteWidget =
        await ColiveCallEngineManager.instance.startPlayStream(streamId);
    if (remoteWidget != null) {
      _fullScreenWidgetStreamController.add(remoteWidget);
      _remotePreviewWidget = remoteWidget;
      _isRemoteCameraEnable = true;
    }

    if (state.callType == ColiveCallType.outgoing ||
        state.callType == ColiveCallType.aib) {
      final userId = state.profileObs.value.id.toString();
      ColiveCallEngineManager.instance.startPushStream(userId);
    } else {
      _sendStartCallingMessage();
    }
  }

  void _onFinishCall(String reason) {
    ColiveLogUtil.i(_tag, "_onFinishCall $reason");
    if (isExitRoom) return;
    isExitRoom = true;

    final roomId = state.callModel.sessionId;
    ColiveCallEngineManager.instance.exitRoom(roomId);
  }

  void _onSettlementCall(ColiveCallSettlementModel data) {
    ColiveLogUtil.i(_tag, "_onSettlementCall ${data.toJson()}");
    if (isCallEnd) return;
    isCallEnd = true;

    Get.until((route) => route.settings.name == ColiveRoutes.callCalling);
    Get.offAndToNamed(
      ColiveRoutes.callFinished,
      arguments: {
        'call_model': state.callModel,
        'call_type': state.callType,
        'settlement_model': data,
      },
    );
  }

  void _forceToExit() {
    ColiveLogUtil.i(_tag, "_forceToExit");
    if (isCallEnd) return;
    isCallEnd = true;

    final roomId = state.callModel.sessionId;
    ColiveCallEngineManager.instance.exitRoom(roomId);
    Get.until((route) => route.settings.name == ColiveRoutes.callCalling);
    Get.back();
  }

  void _onRemoteUserLeave() {
    ColiveLogUtil.w(_tag, "_onRemoteUserLeave");
    final roomId = state.callModel.sessionId;
    ColiveCallEngineManager.instance.exitRoom(roomId);
  }

  void _onRemoteCameraStateUpdate(bool enable) {
    _isRemoteCameraEnable = enable;
    if (enable) {
      final remoteWidget = _remotePreviewWidget;
      if (remoteWidget == null) return;
      _remoteController.add(remoteWidget);
    } else {
      final isRemoteFullPreview = state.isLocalSmallPreviewObs.value;
      final widget = ColiveCallingPlaceholder(
        avatar: state.callModel.anchorAvatar,
        fullScreen: isRemoteFullPreview,
      );
      _remoteController.add(widget);
    }
  }

  void _aiaCallHangup(int playDuration) async {
    ColiveLoadingUtil.show();
    await ColiveCallInvitationManager.instance.apiAIACallHangup(
      callModel: state.callModel,
      callType: state.callType,
      isPlayFinished: state.isAIAPlayFinished,
    );
    ColiveLoadingUtil.dismiss();

    final model = ColiveCallSettlementModel.fromJson({
      'conversation_time': playDuration,
      'anchor_id': state.callModel.anchorId,
      'avatar': state.callModel.anchorAvatar,
      'nickname': state.callModel.anchorNickname,
      'gift': '0',
      'diamonds': '0',
    });
    _onSettlementCall(model);
  }

  void onAiaPlayProgress(int position) {
    _callingSeconds = position;
    state.callingDurationObs.value = ColiveFormatUtil.durationToTime(
      _callingSeconds,
      isShowHour: false,
    );
  }

  void onAiaPlayEnd(int duration) {
    _onFinishCall('Play end');
    _aiaCallHangup(duration);
  }

  void onAiaPlayFailed(Object error) {
    ColiveLogUtil.i(_tag, "play AIA video failed ${error.toString()}");
    Future.delayed(const Duration(seconds: 1), () {
      _forceToExit();
      ColiveLoadingUtil.showToast('colive_no_network'.tr);
    });
  }

  void onTapHangup() async {
    final confirm = await ColiveDialogUtil.showDialog(
      ColiveConfirmDialog(content: 'colive_call_hangup_tips'.tr),
    );
    if (confirm) {
      if (state.callType == ColiveCallType.aia) {
        _onFinishCall('DialogExit');
        _aiaCallHangup(_callingSeconds);
      } else {
        ColiveLoadingUtil.show();
        final result =
            await ColiveCallInvitationManager.instance.apiCallSettlement(
          callModel: state.callModel,
          callType: state.callType,
        );
        ColiveLoadingUtil.dismiss();
        if (result.isSuccess) {
          _onFinishCall('DialogExit');
        } else {
          ColiveLoadingUtil.showToast(result.msg);
          _forceToExit();
        }
      }
    }
  }

  void onTapFlip() {
    ColiveLogUtil.i(_tag, "onTapFlip");
    state.isUseFrontCamera = !state.isUseFrontCamera;
    ColiveCallEngineManager.instance.flipCamera(state.isUseFrontCamera);
  }

  void onTapCamera() async {
    ColiveLogUtil.i(_tag, "onTapCamera");
    final isCameraEnable = !state.isCameraEnableObs.value;
    if (isCameraEnable) {
      _localPreviewWidget =
          await ColiveCallEngineManager.instance.startPreview();
      ColiveCallEngineManager.instance.mutePublishStreamVideo(false);
    } else {
      ColiveCallEngineManager.instance.stopPreview();
      ColiveCallEngineManager.instance.mutePublishStreamVideo(true);
      _localPreviewWidget = ColiveCallingPlaceholder(
        avatar: state.profileObs.value.avatar,
        isSelf: true,
        fullScreen: !state.isLocalSmallPreview,
      );
    }
    final localWidget = _localPreviewWidget;
    if (localWidget != null) {
      _localController.add(localWidget);
    }
    state.isCameraEnableObs.value = isCameraEnable;
  }

  void onTapVoice() async {
    ColiveLogUtil.i(_tag, "onTapVoice");
    final isVoiceEnable = !state.isVoiceEnableObs.value;
    ColiveCallEngineManager.instance.muteMicrophone(!isVoiceEnable);
    state.isVoiceEnableObs.value = isVoiceEnable;
  }

  void onTapSpeaker() async {
    ColiveLogUtil.i(_tag, "onTapSpeaker");
    if (state.callType == ColiveCallType.aia) {
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: false),
      );
    } else {
      final isSpeaker = !state.isSpeakerObs.value;
      ColiveCallEngineManager.instance.muteSpeaker(!isSpeaker);
      state.isSpeakerObs.value = isSpeaker;
    }
  }

  void onTapTopup() {
    ColiveLogUtil.i(_tag, "onTapTopup");
    ColiveDialogUtil.showDialog(
      const ColiveQuickRechargeDialog(isBalanceInsufficient: false),
    );
  }

  void onTapGift() {
    ColiveLogUtil.i(_tag, "onTapGift");
    final sessionId = 'hichat_anchor_${state.callModel.anchorId}';
    Get.bottomSheet(
      ColiveGiftDialog(
        isCalling: true,
        anchorId: state.callModel.anchorId,
        sessionId: sessionId,
        conversationId: state.callModel.conversationId.toString(),
      ),
    );
  }

  void onTapSmallPreview() {
    ColiveLogUtil.i(_tag, "onTapSmallPreview");
    state.isLocalSmallPreview = !state.isLocalSmallPreview;
    final isRemoteFullScreen = state.isLocalSmallPreview;

    final isLocalCameraEnable = state.isCameraEnableObs.value;
    final localPlaceholder = ColiveCallingPlaceholder(
      avatar: state.profileObs.value.avatar,
      isSelf: true,
      fullScreen: !isRemoteFullScreen,
    );
    final remotePlaceholder = ColiveCallingPlaceholder(
      avatar: state.callModel.anchorAvatar,
      isSelf: false,
      fullScreen: isRemoteFullScreen,
    );
    var localWidget =
        isLocalCameraEnable ? _localPreviewWidget : localPlaceholder;
    localWidget ??= localPlaceholder;
    var remoteWidget =
        _isRemoteCameraEnable ? _remotePreviewWidget : remotePlaceholder;
    remoteWidget ??= remotePlaceholder;
    _localController.add(localWidget);
    _remoteController.add(remoteWidget);
  }

  void updateOffsets(Offset offset) {
    state.smallScreenEnd.value = max(
        min(state.smallScreenEnd.value - offset.dx,
            ColiveScreenAdapt.screenWidth - state.smallScreenWidth),
        0);
    state.smallScreenTop.value = max(
        min(state.smallScreenTop.value + offset.dy,
            ColiveScreenAdapt.screenHeight - state.smallScreenHeight),
        0);
  }
}
