import 'dart:async';
import 'dart:convert';

import 'package:colive/services/config/colive_app_config.dart';
import 'package:get/get.dart';
import 'package:colive/common/extensions/colive_string_ext.dart';
import 'package:colive/services/api/colive_api_client.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/managers/colive_chat_extension.dart';
import 'package:nim_core/nim_core.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../common/logger/colive_log_util.dart';
import '../database/colive_database.dart';
import '../models/colive_chat_conversation_model.dart';
import '../models/colive_chat_message_model.dart';
import '../models/colive_gift_base_model.dart';
import '../repositories/colive_anchor_repository.dart';
import 'colive_event_bus_event.dart';

class ColiveChatManager {
  ColiveChatManager._internal();

  static ColiveChatManager? _instance;
  static ColiveChatManager get instance =>
      _instance ??= ColiveChatManager._internal();

  final _appDatabase = Get.find<ColiveDatabase>();
  final _anchorRepository = Get.find<ColiveAnchorRepository>();

  static const _tag = "ChatManager";
  static const messageShowTimeInterval = 3 * 60;

  final subsriptions = <StreamSubscription>[];
  // 敏感词数据
  var sensitiveWordsData = {};

  static String customerServiceName = 'colive_customer_service';
  static const customerServiceOrderBy = 999999;
  static bool isCustomerServiceId(String id) {
    if (ColiveAppPreferenceExt.customerServiceId.isNotEmpty) {
      return id == ColiveAppPreferenceExt.customerServiceId;
    }
    return RegExp(r'^kefu').hasMatch(id);
  }

  // 敏感词过滤
  String _filterSensitiveWords(String orginContent) {
    String check = orginContent;
    // 将内容转换为数组
    List<String> words = check.split(RegExp(r' '));
    // 遍历内容
    for (var i = 0; i < words.length; i++) {
      // 获取内容中的每个单词
      String checkWords = words[i];
      // 将单词转为小写
      String checkWordsLowerCase = checkWords.toLowerCase();
      // 将内容通过key从违禁词Map中获取
      String? contentKeys = sensitiveWordsData[checkWordsLowerCase];
      if (contentKeys != null && contentKeys == '1') {
        // 定义需要转为星号的字符串
        String wordsTips = '';
        // 获取字符串中原内容
        String inputContent = words[i];
        // 将内容变为*
        if (inputContent.length <= 2) {
          if (checkWords.length == 1) {
            wordsTips = '**';
          } else {
            wordsTips = '${inputContent[0]}**${inputContent[1]}';
          }
        } else {
          wordsTips =
              '${inputContent[0]}**${checkWordsLowerCase[checkWords.length - 1]}';
        }
        // 修改内容数组中的字符
        words[i] = wordsTips;
      }
    }
    // 完成内容转换将数组转为字符串通过空格分割开
    check = words.join(r' ');
    return check;
  }

  // 是否包含屏蔽字
  bool _hasShieldedWord(String msg) {
    //网址匹配以及深度链接匹配
    final urlReg = RegExp("[a-zA-z]+://[\\s]*");
    if (urlReg.stringMatch(msg)?.isNotEmpty == true) {
      return true;
    }
    //数字匹配
    final numberReg = RegExp("[0-9]{9,}");
    if (numberReg.stringMatch(msg)?.isNotEmpty == true) {
      return true;
    }
    //特殊数字匹配
    final unusualNumberReg =
        RegExp("⁰|¹|²|³|⁴|⁵|⁶|⁷|⁸|⁹|①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|₁|₂|₃|₄|₅|₆|₇|₈|₉|₀");
    if (unusualNumberReg.stringMatch(msg)?.isNotEmpty == true) {
      return true;
    }

    //数据库匹配
    final wordReg = RegExp("(\\w+)|[\\p{P}\\p{S}\\p{Z}]");
    final allReg = wordReg.allMatches(msg);
    for (var element in allReg) {
      var count = element.groupCount;
      for (int i = 0; i < count; i++) {
        final word = element.group(i);
        if (word != null && word.isNotEmpty) {
          return sensitiveWordsData.containsKey(word);
        }
      }
    }
    return false;
  }

  ///初始化
  Future<void> init() async {
    // 获取客服信息
    _fetchCustomerServiceInfo().then((value) {
      ColiveAppPreferenceExt.customerServiceId = value;
    });
    // 添加事件监听器
    await _setupEventListener();

    bool hasLog = false;
    do {
      // final config = NIMServerConfig(
      //   defaultLink: "link-sg.netease.im:7000",
      //   lbs: "https://lbs.netease.im/lbs/conf.jsp",
      //   nosUploadLbs: "https://wannos.127.net/lbs",
      //   nosUploadDefaultLink: "https://nosup-hz1.127.net",
      //   nosDownloadUrlFormat: "{bucket}-nosdn.netease.im/{object}",
      //   nosUpload: "nosup-hz1.127.net",
      //   nosSupportHttps: true,
      // );
      late NIMSDKOptions options;
      if (GetPlatform.isAndroid) {
        options = NIMAndroidSDKOptions(
          appKey: ColiveAppConfig.nimKey,
          // sdkRootDir: ColivePathUtil.appFilePath,
          // serverConfig: config,
        );
      } else {
        options = options = NIMIOSSDKOptions(
          appKey: ColiveAppConfig.nimKey,
          // sdkRootDir: ColivePathUtil.appFilePath,
          // serverConfig: config,
        );
      }
      final result = await NimCore.instance.initialize(options);
      if (result.isSuccess) {
        ColiveLogUtil.i(_tag, "init SDK success");
        break;
      }
      if (!hasLog) {
        hasLog = true;
        ColiveLogUtil.e(
            _tag,
            "initSDK failed: code=${result.code}, error=${result.errorDetails}",
            true);
      }
      await Future.delayed(const Duration(seconds: 3));
    } while (true);
    await _login();
  }

  Future<void> release() async {
    for (var subsription in subsriptions) {
      subsription.cancel();
    }
    subsriptions.clear();
    await _logout();
    ColiveLogUtil.i(_tag, "release");
  }

  ///登录
  Future<void> _login() async {
    bool hasLog = false;
    do {
      final userId = ColiveAppPreferenceExt.userId;
      final token = ColiveAppPreferenceExt.apiToken;
      final loginInfo = NIMLoginInfo(
        account: 'hichat_$userId',
        token: token.md5,
      );
      final result = await NimCore.instance.authService.login(loginInfo);
      if (result.isSuccess) {
        ColiveLogUtil.i(_tag, "login success");
        break;
      }
      if (!hasLog) {
        hasLog = true;
        ColiveLogUtil.e(_tag, "login failed: code=${result.code}", true);
      }
      await Future.delayed(const Duration(seconds: 3));
    } while (true);
  }

  ///登出
  Future<void> _logout() async {
    final result = await NimCore.instance.authService.logout();
    if (result.isSuccess) {
      ColiveLogUtil.i(_tag, "logout SDK success");
    } else {
      ColiveLogUtil.e(_tag, "logout SDK failed", true);
    }
  }

  ///  事件监听
  Future<void> _setupEventListener() async {
    subsriptions.add(NimCore.instance.authService.authStatus.listen((event) {
      ColiveLogUtil.i(
          _tag, 'AuthService##auth status event : ${event.status.name}');

      switch (event.status) {
        case NIMAuthStatus.unLogin:
          _login();
          break;
        case NIMAuthStatus.dataSyncFinish:
          fetchConversationList();
        default:
          break;
      }
    }));

    subsriptions
        .add(NimCore.instance.userService.onBlackListChanged.listen((list) {
      fetchConversationList();
    }));

    subsriptions
        .add(NimCore.instance.messageService.onSessionUpdate.listen((list) {
      _saveLocalConversationList(list);
    }));

    subsriptions
        .add(NimCore.instance.messageService.onMessage.listen((messages) {
      for (var message in messages) {
        if (message.sessionType != NIMSessionType.p2p) {
          ColiveLogUtil.w(
              _tag, 'Receive invalid message: ${message.toString()}');
          return;
        }
        final localMessage = message.toLocalModel;
        if (localMessage == null) {
          ColiveLogUtil.w(
              _tag, 'Receive invalid message: ${message.toString()}');
          return;
        }

        ColiveLogUtil.i(_tag, 'Receive message: ${message.toMap().toString()}');
        ColiveEventBus.instance.fire(ColiveChatMessageEvent(localMessage));
      }
    }));

    subsriptions
        .add(NimCore.instance.messageService.onMessageStatus.listen((message) {
      final localMessage = message.toLocalModel;
      if (localMessage == null) {
        ColiveLogUtil.w(_tag, 'Invalid message status: ${message.toString()}');
        return;
      }
      ColiveEventBus.instance.fire(ColiveChatMessageEvent(localMessage));
    }));
  }

  ///获取会话列表
  Future<bool> fetchConversationList() async {
    //如果没有客服就添加一个
    if (ColiveAppPreferenceExt.customerServiceId.isEmpty) {
      ColiveAppPreferenceExt.customerServiceId =
          await _fetchCustomerServiceInfo();
    }

    if (ColiveAppPreferenceExt.customerServiceId.isNotEmpty) {
      final customerServiceConversation = await _appDatabase.chatConversationDao
          .getConversationsWithId(ColiveAppPreferenceExt.customerServiceId);
      if (customerServiceConversation == null ||
          customerServiceConversation.isEmpty) {
        final conversation = ColiveChatConversationModel.createCustomerService(
            ColiveAppPreferenceExt.customerServiceId, customerServiceOrderBy);
        await _appDatabase.chatConversationDao.insert(conversation);
      }
    }

    //获取会话列表
    final result = await NimCore.instance.messageService.querySessionList();
    if (result.isSuccess) {
      //拉取成功
      final list = result.data;
      if (list == null) return true;
      await _saveLocalConversationList(list);
    }

    return result.isSuccess;
  }

  Future<String> _fetchCustomerServiceInfo() async {
    final result =
        await Get.find<ColiveApiClient>().fetchCustomerServiceInfo().response;
    final data = result.data;
    if (result.isSuccess && data != null) {
      return data['account'] ?? '';
    }
    return '';
  }

  ///将会话列表保存到本地
  Future<void> _saveLocalConversationList(
      List<NIMSession> nimConversationList) async {
    final List<ColiveChatConversationModel> conversationList = [];
    final conversationDao = _appDatabase.chatConversationDao;
    for (var nimConversation in nimConversationList) {
      var conversation = nimConversation.toLocalModel;
      if (isCustomerServiceId(conversation.id)) {
        conversationList
            .add(conversation.copyWith(orderBy: customerServiceOrderBy));
      } else {
        final localConversation =
            await conversationDao.getConversationsWithId(conversation.id);
        if (localConversation == null || localConversation.isEmpty) {
          final result =
              await NimCore.instance.userService.isInBlackList(conversation.id);
          if (result.isSuccess && result.data == true) {
            // 过滤被拉黑的会话
            continue;
          }
          final anchor = await _anchorRepository.fetchAnchorInfo(
            isRobot: conversation.isRobot,
            anchorId: conversation.userId,
            ignoreCache: false,
            fetchVideos: false,
          );
          if (anchor != null) {
            final newConversation = conversation.copyWith(
              username: anchor.nickname,
              avatar: anchor.avatar,
            );
            conversationList.add(newConversation);
          } else {
            conversationList.add(conversation);
          }
        } else {
          final result =
              await NimCore.instance.userService.isInBlackList(conversation.id);
          if (result.isSuccess && result.data == true) {
            // 过滤被拉黑的会话
            await conversationDao.deleteConversationsWithId(conversation.id);
            continue;
          }
          final newConversation = conversation.copyWith(
            pin: localConversation.first.pin,
            username: localConversation.first.username,
            avatar: localConversation.first.avatar,
          );
          conversationList.add(newConversation);
        }
      }
    }
    await conversationDao.insertAll(conversationList);
  }

  Future<void> saveLocalConversation(
      ColiveChatConversationModel conversation) async {
    final conversationDao = _appDatabase.chatConversationDao;
    await conversationDao.insert(conversation);
  }

  /// 删除会话
  Future<void> deleteConversationWithId(String sessionId) async {
    final sessionInfo = NIMSessionInfo(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
    );
    final result = await NimCore.instance.messageService.deleteSession(
      sessionInfo: sessionInfo,
      deleteType: NIMSessionDeleteType.localAndRemote,
      sendAck: true,
    );
    if (result.isSuccess) {
      final conversationDao = _appDatabase.chatConversationDao;
      await conversationDao.deleteConversationsWithId(sessionId);

      // 删除本地消息
      NimCore.instance.messageService.clearChattingHistory(
        sessionId,
        NIMSessionType.p2p,
        false,
      );
      // 删除云端消息
      NimCore.instance.messageService.clearServerHistory(
        sessionId,
        NIMSessionType.p2p,
        false,
      );
    }
  }

  ///清空指定会话未读数量
  void clearUnreadConversationWithId(String sessionId) async {
    final conversationDao = _appDatabase.chatConversationDao;
    await conversationDao.clearConversationUnreadCount(sessionId);
    final sessionInfo = NIMSessionInfo(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
    );
    await NimCore.instance.messageService
        .clearSessionUnreadCount([sessionInfo]);
  }

  ///清空所有会话未读数量
  void clearUnreadConversationAll() async {
    final conversationDao = _appDatabase.chatConversationDao;
    await conversationDao.clearAllUnread();
    await NimCore.instance.messageService.clearAllSessionUnreadCount();
  }

  Future<bool> updateBlock({required String anchorId, required isBlock}) async {
    if (isBlock) {
      final result =
          await NimCore.instance.userService.addToBlackList(anchorId);
      return result.isSuccess;
    } else {
      final result =
          await NimCore.instance.userService.removeFromBlackList(anchorId);
      return result.isSuccess;
    }
  }

  /// 拉取消息
  Future<List<ColiveChatMessageModel>> fetchMessageList({
    required String sessionId,
    ColiveChatMessageModel? messageModel,
    int limit = 20,
  }) async {
    late NIMMessage anchor;
    if (messageModel != null) {
      final result =
          await NimCore.instance.messageService.queryMessageListByUuid(
        [messageModel.messageId],
        sessionId,
        NIMSessionType.p2p,
      );
      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        anchor = result.data!.first;
      } else {
        anchor = NIMMessage.emptyMessage(
          sessionId: sessionId,
          sessionType: NIMSessionType.p2p,
          timestamp: messageModel.timestamp,
        );
      }
    } else {
      anchor = NIMMessage.emptyMessage(
        sessionId: sessionId,
        sessionType: NIMSessionType.p2p,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }
    final messageRes = await NimCore.instance.messageService.queryMessageListEx(
      anchor,
      QueryDirection.QUERY_OLD,
      limit,
    );
    if (!messageRes.isSuccess || messageRes.data == null) {
      return [];
    }
    final List<ColiveChatMessageModel> messageList = [];
    messageRes.data?.forEach((element) {
      final model = element.toLocalModel;
      if (model != null) {
        messageList.add(model);
      }
    });

    for (int i = 0; i < messageList.length; i++) {
      final prevIndex = i - 1;
      if (messageList.length == 1 || prevIndex < 0) {
        messageList[i].showTime = true;
      } else {
        final interval =
            (messageList[prevIndex].timestamp - messageList[i].timestamp).abs();
        if (interval / 1000 > messageShowTimeInterval) {
          messageList[i].showTime = true;
        }
      }
    }
    return messageList;
  }

  /// 发送文本消息
  Future<bool> sendTextMessage({
    required String sessionId,
    required String text,
  }) async {
    if (!isCustomerServiceId(sessionId)) {
      if (_hasShieldedWord(text)) {
        ColiveLogUtil.e(_tag, "sendTextMessage failed: isShielded");
        final message = NIMMessage.textEmptyMessage(
          sessionId: sessionId,
          sessionType: NIMSessionType.p2p,
          text: text,
        );
        message.status = NIMMessageStatus.success;

        final resMessage = await NimCore.instance.messageService
            .saveMessageToLocalEx(message: message, time: message.timestamp);
        if (resMessage.isSuccess && resMessage.data != null) {
          final localMessage = resMessage.data?.toLocalModel;
          if (localMessage == null) {
            ColiveLogUtil.e(_tag, 'Invalid message: ${resMessage.toString()}');
            return false;
          }
          ColiveEventBus.instance.fire(ColiveChatMessageEvent(localMessage));
        }
        return true;
      }
    }
    final content = _filterSensitiveWords(text);
    final result = await NimCore.instance.messageService.sendTextMessage(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
      text: content,
    );
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
    }
    return result.isSuccess;
  }

  /// 保存文本消息
  Future<bool> saveTextMessage({
    required String sessionId,
    required String text,
  }) async {
    final messageRes = await MessageBuilder.createTextMessage(
        sessionId: sessionId, sessionType: NIMSessionType.p2p, text: text);
    if (messageRes.isSuccess && messageRes.data != null) {
      final message = messageRes.data!;
      final result = await NimCore.instance.messageService
          .saveMessageToLocalEx(message: message, time: message.timestamp);
      if (!result.isSuccess) {
        ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
      }
      return result.isSuccess;
    }
    return false;
  }

  /// 发送emoji消息
  Future<bool> sendEmojiMessage({
    required String sessionId,
    required Map<String, dynamic> emojiMap,
  }) async {
    var attachment = NIMCustomMessageAttachment(data: {
      'type': ColiveChatMessageType.emoji,
      'data': {
        'des': emojiMap.keys.first,
        'png': emojiMap.values.first,
      }
    });
    final result = await NimCore.instance.messageService.sendCustomMessage(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
      attachment: attachment,
    );
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
    }
    return result.isSuccess;
  }

  /// 保存Emoji消息
  Future<bool> saveEmojiMessage({
    required String sessionId,
    required Map<String, dynamic> emojiMap,
  }) async {
    var attachment = NIMCustomMessageAttachment(data: {
      'type': ColiveChatMessageType.emoji,
      'data': {
        'des': emojiMap.keys.first,
        'png': emojiMap.values.first,
      }
    });
    final messageRes = await MessageBuilder.createCustomMessage(
        sessionId: sessionId,
        sessionType: NIMSessionType.p2p,
        attachment: attachment);
    if (messageRes.isSuccess && messageRes.data != null) {
      final message = messageRes.data!;
      final result = await NimCore.instance.messageService
          .saveMessageToLocalEx(message: message, time: message.timestamp);
      if (!result.isSuccess) {
        ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
      }
      return result.isSuccess;
    }
    return false;
  }

  /// 发送image消息
  Future<bool> sendImageMessage({
    required String sessionId,
    required String filePath,
    required int fileSize,
  }) async {
    final result = await NimCore.instance.messageService.sendImageMessage(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
      filePath: filePath,
      fileSize: fileSize,
    );
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
    }
    return result.isSuccess;
  }

  /// 保存image消息
  Future<bool> saveImageMessage({
    required String sessionId,
    required String filePath,
    required int fileSize,
  }) async {
    final messageRes = await MessageBuilder.createImageMessage(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
      filePath: filePath,
      fileSize: fileSize,
    );
    if (messageRes.isSuccess && messageRes.data != null) {
      final message = messageRes.data!;
      final result = await NimCore.instance.messageService
          .saveMessageToLocalEx(message: message, time: message.timestamp);
      if (!result.isSuccess) {
        ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
      }
      return result.isSuccess;
    }
    return false;
  }

  /// 发送礼物消息
  Future<bool> sendGiftMessage({
    required String sessionId,
    required ColiveGiftItemModel gift,
  }) async {
    final Map<String, dynamic> giftMap = {
      'giftLogo': gift.logo,
      'giftId': gift.id,
      'svgaName': gift.cartoonUrl,
    };
    var attachment = NIMCustomMessageAttachment(data: {
      'type': ColiveChatMessageType.gift,
      'data': jsonEncode(giftMap),
    });
    final result = await NimCore.instance.messageService.sendCustomMessage(
      sessionId: sessionId,
      sessionType: NIMSessionType.p2p,
      attachment: attachment,
    );
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
    }
    return result.isSuccess;
  }

  Future<bool> resendMessage(ColiveChatMessageModel messageModel) async {
    final result = await NimCore.instance.messageService.queryMessageListByUuid(
      [messageModel.messageId],
      messageModel.sessionId,
      NIMSessionType.p2p,
    );
    if (!result.isSuccess) {
      ColiveLogUtil.e(_tag, result.errorDetails ?? result.toString());
    }
    if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
      final message = result.data!.first;
      final messageRes =
          await NimCore.instance.messageService.sendMessage(message: message);
      if (!messageRes.isSuccess) {
        ColiveLogUtil.e(_tag, messageRes.errorDetails ?? result.toString());
      }
      return messageRes.isSuccess;
    }
    return false;
  }
}
