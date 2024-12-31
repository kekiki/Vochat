import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:vochat/common/event_bus/vochat_event_bus.dart';
import 'package:vochat/common/extensions/vochat_string_ext.dart';
import 'package:vochat/services/managers/vochat_chat_manager.dart';
import 'package:vochat/common/event_bus/vochat_event_bus_event.dart';
import 'package:vochat/common/widgets/dialogs/vochat_confirm_dialog.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../login/managers/vochat_profile_manager.dart';
import '../../app_macros/vochat_app_macros.dart';
import '../../common/logger/vochat_log_util.dart';
import '../../common/preference/vochat_preference.dart';
import '../../common/database/vochat_database.dart';
import '../../common/topup/vochat_topup_service.dart';
import '../../common/widgets/dialogs/vochat_dialog_util.dart';
import '../../common/widgets/dialogs/vochat_quick_recharge_dialog.dart';
import 'vochat_download_manager.dart';
import '../models/vochat_call_model.dart';

import '../models/vochat_call_settlement_model.dart';
import 'vochat_call_invitation_manager.dart';
import 'vochat_socket_command.dart';

class VochatSocketManager {
  VochatSocketManager._internal();

  static VochatSocketManager? _instance;
  static VochatSocketManager get instance =>
      _instance ??= VochatSocketManager._internal();

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
    VochatLogUtil.i(_tag, "release");
  }

  Future<void> _connect() async {
    try {
      if (_channel == null) {
        _channel = IOWebSocketChannel.connect(VochatAppMacros.socketUrl);
        subsriptions.add(_channel!.stream.listen(
          _onData,
          onDone: _onDone,
          onError: _onError,
        ));
      }
      _sendBindingUserMessage();
    } catch (e) {
      VochatLogUtil.e(_tag, "connect failed:${e.toString()}", true);
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
        VochatLogUtil.e(_tag, "🔗 socket disconnect", true);
      }
    } catch (e) {
      VochatLogUtil.e(_tag, "disconnect failed:${e.toString()}", true);
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
      // VochatLogUtil.i(_tag, 'recieve message: $extend');

      final command = VochatSocketCommand.fromCommand(cmd);
      _receivedCommand(command, extend);
    } catch (e) {
      VochatLogUtil.e(_tag, 'decode error: ${e.toString()}');
    }
  }

  Future<void> _onDone() async {
    isSocketConnected = false;
    VochatLogUtil.e(_tag, 'socket closed');
  }

  Future<void> _onError(err) async {
    isSocketConnected = false;
    VochatLogUtil.e(_tag, 'error: ${err.toString()}');
  }

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Socket Command
  /////////////////////////////////////////////////////////////////////////////

  /// 上行: 发送Socket指令
  void sendCommand(VochatSocketCommand cmd, Map<String, dynamic>? parameters) {
    try {
      if (_channel != null) {
        final Map<String, dynamic> extend = {
          'userId': VochatPreference.userId,
          'app': VochatAppMacros.appName,
          'type': '2',
          'cmd': cmd.command,
        };
        if (parameters != null) {
          extend.addAll(parameters);
        }
        final message = jsonEncode(extend).aesEncode;
        _channel?.sink.add(message);
        // VochatLogUtil.i(_tag, 'send message: $extend');
      }
    } catch (e) {
      VochatLogUtil.e(_tag, 'error: ${e.toString()}');
    }
  }

  void _sendBindingUserMessage() {
    final param = {
      'uid': VochatPreference.userId,
      'token': VochatPreference.token,
    };
    sendCommand(VochatSocketCommand.bindingUser, param);
  }

  void _sendHeartbeatMessage() {
    final param = {'lang': Get.locale?.languageCode ?? 'en'};
    sendCommand(VochatSocketCommand.heartbeat, param);
  }

  void sendStartCallingMessage({required String conversationId}) {
    final param = {'conversation_id': conversationId};
    sendCommand(VochatSocketCommand.startCalling, param);
  }

  void sendPauseCallMessage({required bool isStop}) {
    final param = {'isStop': isStop ? '1' : '0'};
    sendCommand(VochatSocketCommand.pauseReceiveCall, param);
  }

  /// 下行: 接收Socket指令
  void _receivedCommand(
      VochatSocketCommand cmd, Map<String, dynamic> extend) async {
    switch (cmd) {
      case VochatSocketCommand.updateBalance:
        final diamonds = extend['data']['diamonds'] ?? 0;
        final vipDate = extend['data']['vipExpireTime'] ?? 0;
        VochatProfileManager.instance
            .updateDiamondsAndVipDate(diamonds, vipDate);
        break;

      case VochatSocketCommand.preloadVideo:
        final videoList = extend['data'];
        for (var videoUrl in videoList) {
          VochatDownloadManager.instance.preload(videoUrl);
        }
        break;

      case VochatSocketCommand.accountBlocked:
        final data = extend['data'];
        final type = data['type'] ?? 1;
        final title = data['title'] ?? '';
        final reason = data['reason'] ?? '';
        VochatLogUtil.i(_tag, '$type $title $reason');
        await VochatDialogUtil.showDialog(
          VochatConfirmDialog(
            title: title,
            content: reason,
            onlyConfirm: true,
          ),
        );
        VochatProfileManager.instance.logout();
        break;

      case VochatSocketCommand.rechargeDiscount:
        // show discount product
        break;

      case VochatSocketCommand.anchorStatusChanged:
        final anchorId = extend['data']['userId'] ?? 0;
        final online = extend['data']['online'] ?? 0;

        final anchorDao = Get.find<VochatDatabase>().anchorDao;
        final anchor = await anchorDao.findAnchorById(anchorId);
        if (anchor != null && anchor.online != online) {
          final newAnchor = anchor.copyWith(online: online);
          await anchorDao.updateAnchor(newAnchor);
        }
        VochatEventBus.instance.fire(VochatAnchorStatusChangedEvent(
          anchorId: anchorId,
          online: online,
        ));

      /// call

      case VochatSocketCommand.receivedAIBCall:
        final callModel = VochatCallModel.fromJson(extend['data']).copyWith(
          anchorId: extend['data']['userId'],
          anchorAvatar: extend['data']['avatar'],
          anchorNickname: extend['data']['nickname'],
          conversationPrice: extend['data']['price']?.toString(),
        );
        VochatCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: VochatCallType.aib,
        );
        break;

      case VochatSocketCommand.receivedAIACall:
        final callModel = VochatCallModel.fromJson(extend['data']).copyWith(
          anchorId: extend['data']['userId'],
          anchorAvatar: extend['data']['avatar'],
          anchorNickname: extend['data']['nickname'],
          conversationPrice: extend['data']['price']?.toString(),
        );
        VochatCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: VochatCallType.aia,
        );
        break;

      case VochatSocketCommand.receivedCall:
        final callModel = VochatCallModel.fromJson(extend['data']);
        VochatCallInvitationManager.instance.receiveCallInvitation(
          callModel: callModel,
          callType: VochatCallType.recieved,
        );
        break;

      case VochatSocketCommand.settlementCall:
        final data = VochatCallSettlementModel.fromJson(extend['data']);
        VochatCallInvitationManager.instance.serverSettlementCallFinished(data);
        break;

      case VochatSocketCommand.anchorRefuseCall:
        VochatCallInvitationManager.instance.anchorRefuseCallInvitation();
        break;

      case VochatSocketCommand.followUpdate:
        var type = extend['data']['type'] ?? 0;
        var num = extend['data']['num'] ?? 0;
        if (type > 0 && num > 0) {
          var userInfo = VochatProfileManager.instance.userInfo;
          var isUpdate = false;

          ///1关注的数量 2粉丝数量 3拉黑数量
          // if (type == 1) {
          //   isUpdate = userInfo.follow != num;
          //   userInfo = userInfo.copyWith(follow: num);
          // } else if (type == 2) {
          //   isUpdate = userInfo.fans != num;
          //   userInfo = userInfo.copyWith(fans: num);
          // } else if (type == 3) {
          //   isUpdate = userInfo.block != num;
          //   userInfo = userInfo.copyWith(block: num);
          // }
          if (isUpdate) {
            VochatProfileManager.instance.updateLocalInfo(userInfo, true);
          }
        }
        break;

      case VochatSocketCommand.sensitiveUpdate:
        List sensWords = extend['data']['sensWords'];
        VochatChatManager.instance.sensitiveWordsData =
            sensWords.fold({}, (map, fruit) {
          String text = fruit;
          map[text.toLowerCase()] = '1';
          return map;
        });
        break;

      case VochatSocketCommand.cardUpdate:
        final cardNum = extend['data']['num'];
        var userInfo = VochatProfileManager.instance.userInfo;
        // if (userInfo.cardNum != cardNum) {
        //   userInfo = userInfo.copyWith(cardNum: cardNum);
        //   VochatProfileManager.instance.updateLocalInfo(userInfo, true);
        // }
        break;

      case VochatSocketCommand.showRecharge:
        VochatDialogUtil.showDialog(
          const VochatQuickRechargeDialog(isBalanceInsufficient: false),
        );
        break;

      case VochatSocketCommand.productUpdate:
        VochatTopupService.instance.refreshAllProductList();
        break;

      default:
        break;
    }
  }
}
