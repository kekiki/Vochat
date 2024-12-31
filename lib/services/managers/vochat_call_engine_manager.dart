import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../../app_macros/vochat_app_macros.dart';
import '../../common/logger/vochat_log_util.dart';

class VochatCallEngineManager {
  VochatCallEngineManager._internal();

  static VochatCallEngineManager? _instance;
  static VochatCallEngineManager get instance =>
      _instance ??= VochatCallEngineManager._internal();

  static int _localPreviewId = 0;
  static int _remotePreviewId = 0;

  static const _tag = "CallEngineManager";
  bool _isEngineInit = false;

  Future<void> _init() async {
    ZegoExpressEngine.setRoomMode(ZegoRoomMode.SingleRoom);
    ZegoEngineProfile profile = ZegoEngineProfile(
      // VochatAppMacros.zegoAppId,
      0,
      ZegoScenario.StandardVideoCall,
      // appSign: VochatAppMacros.zegoAppSign,
      appSign: '',
    );
    await ZegoExpressEngine.createEngineWithProfile(profile);
    _isEngineInit = true;
  }

  Future<void> _release() async {
    if (_localPreviewId != 0) {
      ZegoExpressEngine.instance.destroyCanvasView(_localPreviewId);
      _localPreviewId = 0;
    }
    if (_remotePreviewId != 0) {
      ZegoExpressEngine.instance.destroyCanvasView(_remotePreviewId);
      _remotePreviewId = 0;
    }
    _instance = null;
    await ZegoExpressEngine.destroyEngine();
    _isEngineInit = false;
  }

  // 未使用token机制
  Future<void> enterRoom(
      String roomId, String userId /*, String token*/) async {
    if (!_isEngineInit) await _init();

    VochatLogUtil.i(_tag, "login: roomId=$roomId, userId=$userId");
    ZegoUser user = ZegoUser.id(userId);
    ZegoRoomConfig config = ZegoRoomConfig.defaultConfig();
    config.isUserStatusNotify = true;
    // config.token = token;
    final result = await ZegoExpressEngine.instance
        .loginRoom(roomId, user, config: config);
    VochatLogUtil.i(
        _tag, "login result: roomId=$roomId, errorCode=${result.errorCode}");
  }

  Future<void> exitRoom(String? roomId) async {
    VochatLogUtil.i(_tag, "logout: roomId=$roomId");
    final result = await ZegoExpressEngine.instance.logoutRoom(roomId);
    VochatLogUtil.i(
        _tag, "logout result: roomId=$roomId, errorCode=${result.errorCode}");
    _release();
  }

  Future<void> listen({
    required String notifyUserId,
    Function(bool result)? onJoinRoom,
    Function(String)? onFinishCall,
    Function()? onRemoteUserJoin,
    Function()? onRemoteUserLeave,
    Function(String streamId)? onStreamAdd,
    Function(int remainTimeInSecond)? onRoomTokenWillExpire,
    Function(bool enable)? onRemoteCameraStateUpdate,
  }) async {
    if (!_isEngineInit) await _init();
    // 房间状态更新回调
    ZegoExpressEngine.onRoomStateUpdate = (String roomID, ZegoRoomState state,
        int errorCode, Map<String, dynamic> extendedData) {
      VochatLogUtil.d(_tag,
          "onRoomStateUpdate: roomID=$roomID, state=$state, errorCode=$errorCode");
    };
    // 房间状态改变回调
    ZegoExpressEngine.onRoomStateChanged = (String roomID,
        ZegoRoomStateChangedReason reason,
        int errorCode,
        Map<String, dynamic> extendedData) {
      VochatLogUtil.d(_tag,
          "onRoomStateChanged: roomID=$roomID, reason=$reason, errorCode=$errorCode");

      switch (reason) {
        case ZegoRoomStateChangedReason.Logined:
          onJoinRoom?.call(true);
          break;
        case ZegoRoomStateChangedReason.LoginFailed:
          onJoinRoom?.call(false);
          break;
        case ZegoRoomStateChangedReason.ReconnectFailed:
          onFinishCall?.call("ReconnectFailed");
          break;
        case ZegoRoomStateChangedReason.KickOut:
          onFinishCall?.call("KickOut");
          break;
        case ZegoRoomStateChangedReason.Logout:
          onFinishCall?.call("Logout");
          break;
        default:
          // do nothing
          break;
      }
    };
    // 用户状态更新
    ZegoExpressEngine.onRoomUserUpdate =
        (String roomID, ZegoUpdateType updateType, List<ZegoUser> userList) {
      VochatLogUtil.i(_tag,
          "onRoomUserUpdate: roomID=$roomID, updateType=$updateType, userList=${userList.map((e) => e.userID)}");
      final isContainUserId =
          userList.where((user) => user.userID == notifyUserId).isNotEmpty;
      if (!isContainUserId) return;
      switch (updateType) {
        case ZegoUpdateType.Add:
          // remote user join
          onRemoteUserJoin?.call();
          break;
        case ZegoUpdateType.Delete:
          // remote user logout
          onRemoteUserLeave?.call();
          break;
      }
    };
    // 流状态更新
    ZegoExpressEngine.onRoomStreamUpdate = (
      String roomID,
      ZegoUpdateType updateType,
      List<ZegoStream> streamList,
      Map<String, dynamic> extendedData,
    ) {
      final streamIdList = streamList.map((e) => e.streamID);
      VochatLogUtil.i(_tag,
          "onRoomStreamUpdate: roomID=$roomID, updateType=$updateType, streamList=$streamIdList");
      switch (updateType) {
        case ZegoUpdateType.Add:
          if (streamList.isNotEmpty) {
            final streamId = streamList.first.streamID;
            onStreamAdd?.call(streamId);
          }
          break;
        case ZegoUpdateType.Delete:
          break;
      }
    };
    // 推流状态更新回调
    ZegoExpressEngine.onPublisherStateUpdate = (
      String streamID,
      ZegoPublisherState state,
      int errorCode,
      Map<String, dynamic> extendedData,
    ) {
      VochatLogUtil.i(_tag,
          "onPublisherStateUpdate: streamID=$streamID, state=$state, errorCode=$errorCode");
    };
    // 拉流状态相关回调
    ZegoExpressEngine.onPlayerStateUpdate = (String streamID,
        ZegoPlayerState state,
        int errorCode,
        Map<String, dynamic> extendedData) {
      VochatLogUtil.i(_tag,
          "onPlayerStateUpdate: streamID=$streamID, state=$state, errorCode=$errorCode");
    };
    // Token将要过期前30s的提醒
    ZegoExpressEngine.onRoomTokenWillExpire =
        (String roomID, int remainTimeInSecond) {
      VochatLogUtil.i(_tag,
          "onRoomTokenWillExpire: roomID=$roomID, remainTimeInSecond=$remainTimeInSecond");
      onRoomTokenWillExpire?.call(remainTimeInSecond);
    };
    // 调检测设备是否异常
    ZegoExpressEngine.onLocalDeviceExceptionOccurred =
        (ZegoDeviceExceptionType exceptionType, ZegoDeviceType deviceType,
            String deviceID) {
      VochatLogUtil.i(_tag,
          "onLocalDeviceExceptionOccurred: exceptionType=$exceptionType, deviceType=$deviceType");
    };

    ZegoExpressEngine.onRemoteCameraStateUpdate =
        (String streamID, ZegoRemoteDeviceState state) {
      VochatLogUtil.i(_tag,
          "onRemoteCameraStateUpdate:onRemoteCameraStateUpdate => streamID=$streamID, state=$state");
      if (state == ZegoRemoteDeviceState.Open) {
        onRemoteCameraStateUpdate?.call(true);
      } else if (state == ZegoRemoteDeviceState.Mute) {
        onRemoteCameraStateUpdate?.call(false);
      }
    };
  }

  void setupVideoConfig() {
    // 设置推流视频配置
    ZegoVideoConfig videoConfig = ZegoVideoConfig(
      720,
      1280,
      720,
      1280,
      24,
      1500,
      ZegoVideoCodecID.Default,
    );
    ZegoExpressEngine.instance.setVideoConfig(videoConfig);
  }

  void startPushStream(String streamId) {
    ZegoExpressEngine.instance.startPublishingStream(streamId);
  }

  void stopPublishStream() {
    ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<Widget?> startPreview([bool useFrontCamera = true]) async {
    await ZegoExpressEngine.instance.enableCamera(true);
    await ZegoExpressEngine.instance.useFrontCamera(useFrontCamera);
    await _checkIfNeedDestroyView(_localPreviewId);
    final previewWidget =
        await ZegoExpressEngine.instance.createCanvasView((viewID) {
      _localPreviewId = viewID;
      ZegoCanvas previewCanvas = ZegoCanvas.view(viewID);
      previewCanvas.viewMode = ZegoViewMode.AspectFill;
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    });
    return previewWidget;
  }

  void stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (_localPreviewId != 0) {
      ZegoExpressEngine.instance.destroyCanvasView(_localPreviewId);
      _localPreviewId = 0;
    }
  }

  Future<Widget?> startPlayStream(String streamId) async {
    await _checkIfNeedDestroyView(_remotePreviewId);
    final previewWidget =
        await ZegoExpressEngine.instance.createCanvasView((viewID) {
      _remotePreviewId = viewID;
      ZegoCanvas canvas = ZegoCanvas.view(viewID);
      canvas.viewMode = ZegoViewMode.AspectFill;
      ZegoExpressEngine.instance.startPlayingStream(streamId, canvas: canvas);
    });
    return previewWidget;
  }

  void stopPlayStream(String streamId) {
    ZegoExpressEngine.instance.stopPlayingStream(streamId);
    if (_remotePreviewId != 0) {
      ZegoExpressEngine.instance.destroyCanvasView(_remotePreviewId);
      _remotePreviewId = 0;
    }
  }

  void flipCamera(bool useFrontCamera) {
    ZegoExpressEngine.instance.useFrontCamera(useFrontCamera);
  }

  void mutePublishStreamVideo(bool mute) {
    ZegoExpressEngine.instance.mutePublishStreamVideo(mute);
  }

  void mutePublishStreamAudio(bool mute) {
    ZegoExpressEngine.instance.mutePublishStreamAudio(mute);
  }

  void mutePlayStreamVideo(String streamId, bool mute) {
    ZegoExpressEngine.instance.mutePlayStreamVideo(streamId, mute);
  }

  void mutePlayStreamAudio(String streamId, bool mute) {
    ZegoExpressEngine.instance.mutePlayStreamAudio(streamId, mute);
  }

  void muteSpeaker(bool mute) {
    ZegoExpressEngine.instance.muteSpeaker(mute);
  }

  void muteMicrophone(bool mute) {
    ZegoExpressEngine.instance.muteMicrophone(mute);
  }

  void startRecordingCapture(String filePath, bool isVideo) {
    final type = isVideo
        ? ZegoDataRecordType.AudioAndVideo
        : ZegoDataRecordType.OnlyAudio;
    final config = ZegoDataRecordConfig(filePath, type);
    ZegoExpressEngine.instance
        .startRecordingCapturedData(config, channel: ZegoPublishChannel.Main);
  }

  Future<void> _checkIfNeedDestroyView(int viewId) async {
    if (viewId == 0) {
      VochatLogUtil.d(_tag, "_checkIfNeedDestroyView: viewId=$viewId");
      return;
    }
    final success = await ZegoExpressEngine.instance.destroyCanvasView(viewId);
    VochatLogUtil.d(
        _tag, "_checkIfNeedDestroyView: destroyCanvasView success=$success");
  }
}
