import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:colive/common/event_bus/colive_event_bus.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:colive/services/managers/colive_event_bus_event.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../common/logger/colive_log_util.dart';
import '../config/colive_app_config.dart';
import '../database/colive_database.dart';
import '../widgets/dialogs/colive_dialog_util.dart';
import '../widgets/dialogs/colive_quick_recharge_dialog.dart';
import 'colive_download_manager.dart';
import '../extensions/colive_preference_ext.dart';
import '../extensions/colive_string_ext.dart';
import '../models/colive_call_model.dart';

import '../models/colive_call_settlement_model.dart';
import '../topup/colive_topup_service.dart';
import 'colive_call_invitation_manager.dart';
import 'colive_profile_manager.dart';
import 'colive_socket_command.dart';

class ColiveSocketManager {
  ColiveSocketManager._internal();

  static ColiveSocketManager? _instance;
  static ColiveSocketManager get instance =>
      _instance ??= ColiveSocketManager._internal();

  static const _tag = "SocketManager";

  WebSocketChannel? _channel;
  final subsriptions = <StreamSubscription>[];
  bool isSocketConnected = false;

  Timer? _heartbeatTimer;
  int _heartbeatTimeInterval = 0;

  Future<void> init() async {
    await _connect();
  }

  Future<void> release() async {
    await _disconnect();
    ColiveLogUtil.i(_tag, "release");
  }

  Future<void> _connect() async {
    try {
      if (_channel == null) {
        _channel = IOWebSocketChannel.connect(ColiveAppConfig.socketUrl);
        subsriptions.add(_channel!.stream.listen(
          _onData,
          onDone: _onDone,
          onError: _onError,
        ));
      }
      _sendBindingUserMessage();
    } catch (e) {
      ColiveLogUtil.e(_tag, "connect failed:${e.toString()}", true);
    } finally {
      _startHeartbeatTimer();
    }
  }

  Future<void> _reconnect() async {
    if (isSocketConnected) return;
    await _disconnect();
    await _connect();
  }

  ///登出
  Future<void> _disconnect() async {
    try {
      _stopHeartbeatTimer();
      for (var subsription in subsriptions) {
        subsription.cancel();
      }
      subsriptions.clear();
      if (_channel != null) {
        isSocketConnected = false;
        _channel?.sink.close();
        _channel = null;
        ColiveLogUtil.e(_tag, "🔗 socket disconnect", true);
      }
    } catch (e) {
      ColiveLogUtil.e(_tag, "disconnect failed:${e.toString()}", true);
    }
  }

  void _startHeartbeatTimer() {
    _stopHeartbeatTimer();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      /// reconnect if 30s not recieved heartbeat
      final interval = DateTime.now().millisecondsSinceEpoch;
      if (interval - _heartbeatTimeInterval > 30000) {
        isSocketConnected = false;
        _reconnect();
      } else {
        _sendHeartbeatMessage();
      }
    });
  }

  void _stopHeartbeatTimer() {
    if (_heartbeatTimer != null) {
      _heartbeatTimer?.cancel();
      _heartbeatTimer = null;
    }
  }

  Future<void> _onData(dynamic event) async {
    try {
      isSocketConnected = true;
      _heartbeatTimeInterval = DateTime.now().millisecondsSinceEpoch;

      final extend = jsonDecode((event as String).aesDecode);
      final cmd = extend['cmd'].toString();
      // ColiveLogUtil.i(_tag, 'recieve message: $extend');

      final command = ColiveSocketCommand.fromCommand(cmd);
      _receivedCommand(command, extend);
    } catch (e) {
      ColiveLogUtil.e(_tag, 'decode error: ${e.toString()}');
    }
  }

  Future<void> _onDone() async {
    isSocketConnected = false;
    ColiveLogUtil.e(_tag, 'socket closed');
  }

  Future<void> _onError(err) async {
    isSocketConnected = false;
    ColiveLogUtil.e(_tag, 'error: ${err.toString()}');
  }

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Socket Command
  /////////////////////////////////////////////////////////////////////////////

  /// 上行: 发送Socket指令
  void sendCommand(
      ColiveSocketCommand cmd, Map<String, dynamic>? parameters) {
    try {
      if (_channel != null) {
        final Map<String, dynamic> extend = {
          'userId': ColiveAppPreferenceExt.userId,
          'app': ColiveAppConfig.appName,
          'type': '2',
          'cmd': cmd.command,
        };
        if (parameters != null) {
          extend.addAll(parameters);
        }
        final message = jsonEncode(extend).aesEncode;
        _channel?.sink.add(message);
        // ColiveLogUtil.i(_tag, 'send message: $extend');
      }
    } catch (e) {
      ColiveLogUtil.e(_tag, 'error: ${e.toString()}');
    }
  }

  void _sendBindingUserMessage() {
    final param = {
      'uid': ColiveAppPreferenceExt.userId,
      'token': ColiveAppPreferenceExt.apiToken,
    };
    sendCommand(ColiveSocketCommand.bindingUser, param);
  }

  void _sendHeartbeatMessage() {
    final param = {'lang': Get.locale?.languageCode ?? 'en'};
    sendCommand(ColiveSocketCommand.heartbeat, param);
  }

  void sendStartCallingMessage({required String conversationId}) {
    final param = {'conversation_id': conversationId};
    sendCommand(ColiveSocketCommand.startCalling, param);
  }

  void sendPauseCallMessage({required bool isStop}) {
    final param = {'isStop': isStop ? '1' : '0'};
    sendCommand(ColiveSocketCommand.pauseReceiveCall, param);
  }

  /// 下行: 接收Socket指令
  void _receivedCommand(
      ColiveSocketCommand cmd, Map<String, dynamic> extend) async {
    switch (cmd) {
      case ColiveSocketCommand.updateBalance:
        final diamonds = extend['data']['diamonds'] ?? 0;
        final vipDate = extend['data']['vipExpireTime'] ?? 0;
        ColiveProfileManager.instance
            .updateDiamondsAndVipDate(diamonds, vipDate);
        break;

      case ColiveSocketCommand.preloadVideo:
        final videoList = extend['data'];
        for (var videoUrl in videoList) {
          ColiveDownloadManager.instance.preload(videoUrl);
        }
        break;

      case ColiveSocketCommand.accountBlocked:
        final data = extend['data'];
        final type = data['type'] ?? 1;
        final title = data['title'] ?? '';
        final reason = data['reason'] ?? '';
        ColiveLogUtil.i(_tag, '$type $title $reason');
        await ColiveDialogUtil.showDialog(
          ColiveConfirmDialog(
            title: title,
            content: reason,
            onlyConfirm: true,
          ),
        );
        ColiveProfileManager.instance.logout();
        break;

      case ColiveSocketCommand.rechargeDiscount:
        // show discount product
        break;

      case ColiveSocketCommand.anchorStatusChanged:
        final anchorId = extend['data']['userId'] ?? 0;
        final online = extend['data']['online'] ?? 0;

        final anchorDao = Get.find<ColiveDatabase>().anchorDao;
        final anchor = await anchorDao.findAnchorById(anchorId);
        if (anchor != null && anchor.online != online) {
          final newAnchor = anchor.copyWith(online: online);
          await anchorDao.updateAnchor(newAnchor);
        }
        ColiveEventBus.instance.fire(ColiveAnchorStatusChangedEvent(
          anchorId: anchorId,
          online: online,
        ));

      /// call

      case ColiveSocketCommand.receivedAIBCall:
        final callModel = ColiveCallModel.fromJson(extend['data']).copyWith(
          anchorId: extend['data']['userId'],
          anchorAvatar: extend['data']['avatar'],
          anchorNickname: extend['data']['nickname'],
          conversationPrice: extend['data']['price']?.toString(),
        );
        ColiveCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: ColiveCallType.aib,
        );
        break;

      case ColiveSocketCommand.receivedAIACall:
        final callModel = ColiveCallModel.fromJson(extend['data']).copyWith(
          anchorId: extend['data']['userId'],
          anchorAvatar: extend['data']['avatar'],
          anchorNickname: extend['data']['nickname'],
          conversationPrice: extend['data']['price']?.toString(),
        );
        ColiveCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: ColiveCallType.aia,
        );
        break;

      case ColiveSocketCommand.receivedCall:
        final callModel = ColiveCallModel.fromJson(extend['data']);
        ColiveCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: ColiveCallType.recieved,
        );
        break;

      case ColiveSocketCommand.settlementCall:
        final data = ColiveCallSettlementModel.fromJson(extend['data']);
        ColiveCallInvitationManager.instance
            .serverSettlementCallFinished(data);
        break;

      case ColiveSocketCommand.anchorRefuseCall:
        ColiveCallInvitationManager.instance.anchorRefuseCallInvitation();
        break;

      case ColiveSocketCommand.followUpdate:
        var type = extend['data']['type'] ?? 0;
        var num = extend['data']['num'] ?? 0;
        if (type > 0 && num > 0) {
          var userInfo = ColiveProfileManager.instance.userInfo;
          var isUpdate = false;

          ///1关注的数量 2粉丝数量 3拉黑数量
          if (type == 1) {
            isUpdate = userInfo.follow != num;
            userInfo = userInfo.copyWith(follow: num);
          } else if (type == 2) {
            isUpdate = userInfo.fans != num;
            userInfo = userInfo.copyWith(fans: num);
          } else if (type == 3) {
            isUpdate = userInfo.block != num;
            userInfo = userInfo.copyWith(block: num);
          }
          if (isUpdate) {
            ColiveProfileManager.instance.updateLocalInfo(userInfo, true);
          }
        }
        break;

      case ColiveSocketCommand.sensitiveUpdate:
        List sensWords = extend['data']['sensWords'];
        ColiveChatManager.instance.sensitiveWordsData =
            sensWords.fold({}, (map, fruit) {
          String text = fruit;
          map[text.toLowerCase()] = '1';
          return map;
        });
        break;

      case ColiveSocketCommand.cardUpdate:
        final cardNum = extend['data']['num'];
        var userInfo = ColiveProfileManager.instance.userInfo;
        if (userInfo.cardNum != cardNum) {
          userInfo = userInfo.copyWith(cardNum: cardNum);
          ColiveProfileManager.instance.updateLocalInfo(userInfo, true);
        }
        break;

      case ColiveSocketCommand.showRecharge:
        ColiveDialogUtil.showDialog(
          const ColiveQuickRechargeDialog(isBalanceInsufficient: false),
        );
        break;

      case ColiveSocketCommand.productUpdate:
        ColiveTopupService.instance.refreshAllProductList();
        break;

      default:
        break;
    }
  }
}
