import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:colive/generated/assets.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../common/logger/colive_log_util.dart';
import '../../common/utils/colive_loading_util.dart';
import '../../services/widgets/dialogs/colive_dialog_util.dart';
import '../../services/widgets/dialogs/colive_quick_recharge_dialog.dart';
import '../../services/managers/colive_call_engine_manager.dart';
import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_api_response.dart';
import '../../services/models/colive_call_model.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/widgets/colive_base_controller.dart';
import 'colive_call_waiting_state.dart';

class ColiveCallWaitingController extends ColiveBaseController {
  final state = ColiveCallWaitingState();

  final _tag = 'CallWaiting';
  Timer? _timer;

  AudioPlayer? _audioPlayer;

  @override
  void onInit() {
    final arguments = Get.arguments;
    state.callModel = arguments['call_model'];
    state.callType = arguments['call_type'];
    super.onInit();
    _startInviteTimer();
    _startAudioPlayer();
  }

  @override
  void onClose() {
    _stopInviteTimer();
    _stopAudioPlayer();
    super.onClose();
  }

  @override
  void setupListener() {
    ColiveCallEngineManager.instance.listen(
      notifyUserId: state.callModel.anchorId.toString(),
      onRemoteUserJoin: () {
        ColiveLogUtil.i('Call invitation', 'onRemoteUserJoin');
        _goCallingPage();
      },
    );

    subsriptions.add(ColiveEventBus.instance
        .on<ColiveAnchorsRefuseCallEvent>()
        .listen((event) {
      _exitWatingPage();
    }));
  }

  Future<void> _startAudioPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer?.setAsset(Assets.audioColiveCallAudio);
      await _audioPlayer?.setLoopMode(LoopMode.one);
      await _audioPlayer?.play();
    } on PlayerException catch (e) {
      ColiveLogUtil.e(_tag, "Error loading audio source: $e");
    }
  }

  Future<void> _stopAudioPlayer() async {
    _audioPlayer?.stop();
    _audioPlayer?.dispose();
  }

  void _startInviteTimer() {
    _stopInviteTimer();
    var countdown = ColiveCallWaitingState.connectSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown -= 1;
      if (countdown <= 0) {
        timer.cancel();
        _onCallTimeout();
      }
    });
  }

  void _stopInviteTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _goCallingPage() {
    Get.until((route) => route.settings.name == ColiveRoutes.callWaiting);
    Get.offAndToNamed(
      ColiveRoutes.callCalling,
      arguments: {
        'call_model': state.callModel,
        'call_type': state.callType,
      },
    );
  }

  void _exitWatingPage() {
    ColiveCallEngineManager.instance.exitRoom(state.callModel.sessionId);
    Get.until((route) => route.settings.name == ColiveRoutes.callWaiting);
    Get.back();
  }

  void _onCallTimeout() {
    ColiveCallEngineManager.instance.exitRoom(state.callModel.sessionId);
    ColiveCallInvitationManager.instance.apiCallTimeout(
      callModel: state.callModel,
      callType: state.callType,
    );
    Get.back();
  }

  void onCallHangup() {
    ColiveCallEngineManager.instance.exitRoom(state.callModel.sessionId);
    ColiveCallInvitationManager.instance.apiCallRefuse(
      callModel: state.callModel,
      callType: state.callType,
    );
    Get.back();
  }

  Future<void> onCallAgree() async {
    ColiveLogUtil.i(_tag, 'agree call invitation');

    final hasPermissions =
        await ColiveCallInvitationManager.instance.checkHasCallPermissions();
    if (!hasPermissions) return;

    if (state.callType == ColiveCallType.aia) {
      ColiveCallInvitationManager.instance.apiCallAnswer(
        callModel: state.callModel,
        callType: state.callType,
      );
      _goCallingPage();
      return;
    }

    final userInfo = ColiveProfileManager.instance.userInfo;
    final price = int.parse(state.callModel.conversationPrice);
    if (price > 0 &&
        userInfo.diamonds < price &&
        !ColiveProfileManager.instance.hasFreeCallCard) {
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return;
    }

    if (state.callType == ColiveCallType.aib) {
      state.isAIBConnecting.value = true;
      _startInviteTimer();
      ColiveCallEngineManager.instance.listen(
        notifyUserId: state.callModel.anchorId.toString(),
        onJoinRoom: (success) {
          ColiveLogUtil.i(_tag, 'onJoinRoom: $success');
          if (!success) {
            ColiveLoadingUtil.dismiss();
            ColiveLoadingUtil.showToast('colive_call_failed'.tr);
            onCallHangup();
            return;
          }
          _inviteRemoteAnchor(anchorId: state.callModel.anchorId);
        },
        onRemoteUserJoin: () {
          ColiveLogUtil.i('Call invitation', 'onRemoteUserJoin');
          _goCallingPage();
        },
      );

      ColiveLoadingUtil.show();
      final userId = userInfo.id.toString();
      ColiveCallEngineManager.instance
          .enterRoom(state.callModel.sessionId, userId);
      return;
    }

    ColiveApiResponse? result;
    try {
      result = await ColiveCallInvitationManager.instance.apiCallAnswer(
        callModel: state.callModel,
        callType: state.callType,
      );
    } catch (e) {
      ColiveLogUtil.e(_tag, 'on call failed: ${e.toString()}');
    }

    if (result == null || !result.isSuccess) {
      ColiveLoadingUtil.showToast('colive_call_failed'.tr);
      onCallHangup();
      return;
    }

    ColiveCallEngineManager.instance.listen(
      notifyUserId: state.callModel.anchorId.toString(),
      onJoinRoom: (success) {
        ColiveLoadingUtil.dismiss();
        ColiveLogUtil.i(_tag, 'onJoinRoom: $success');
        if (!success) {
          ColiveLoadingUtil.showToast('colive_call_failed'.tr);
          onCallHangup();
          return;
        }
      },
      onRemoteUserJoin: () {
        ColiveLogUtil.i('Received invitation', 'onRemoteUserJoin');
        _goCallingPage();
      },
    );

    ColiveLoadingUtil.show();
    final roomId = state.callModel.sessionId;
    final userId = userInfo.id.toString();
    ColiveCallEngineManager.instance.enterRoom(roomId, userId);
  }

  Future<void> _inviteRemoteAnchor({required int anchorId}) async {
    ColiveApiResponse<ColiveCallModel>? result;
    try {
      final isRobot = state.callType == ColiveCallType.aib;
      result = await ColiveCallInvitationManager.instance
          .apiCreateCall(anchorId: anchorId, isRobot: isRobot);
    } catch (e) {
      ColiveLogUtil.e(_tag, 'call create failed: ${e.toString()}');
    } finally {
      ColiveLoadingUtil.dismiss();
    }

    if (result == null || !result.isSuccess || result.data == null) {
      ColiveLoadingUtil.showToast('colive_call_failed'.tr);
      ColiveLogUtil.e(_tag, 'call create failed: ${result.toString()}');
      onCallHangup();
      return;
    }
    final callModel = result.data!;
    final roomId = state.callModel.sessionId;
    if (callModel.isAnchorBusy ||
        callModel.isAnchorOffline ||
        callModel.isNotEnoughDiamonds) {
      ColiveLoadingUtil.showToast('colive_call_failed'.tr);
      onCallHangup();
      return;
    }
    state.callModel = callModel.copyWith(sessionId: roomId);
  }
}
