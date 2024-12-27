import 'dart:convert';
import 'dart:io';

import 'package:nim_core/nim_core.dart';

import '../../common/logger/colive_log_util.dart';
import '../models/colive_chat_conversation_model.dart';
import '../models/colive_chat_message_model.dart';

extension NIMSessionExt on NIMSession {
  ColiveChatConversationModel get toLocalModel {
    var summary = lastMessageContent ?? '';
    if (lastMessageType == NIMMessageType.image) {
      summary = 'colive_picture';
    } else if (lastMessageType == NIMMessageType.video) {
      summary = 'colive_video';
    } else if (lastMessageType == NIMMessageType.audio) {
      summary = 'colive_voice';
    } else if (lastMessageType == NIMMessageType.custom) {
      final attachment = lastMessageAttachment as NIMCustomMessageAttachment?;
      final attachmentMap = attachment?.data ?? {};
      final customMsgType = int.tryParse(attachmentMap['type'].toString());
      if (customMsgType == ColiveChatMessageType.call) {
        summary = 'colive_video_call';
      } else if (customMsgType == ColiveChatMessageType.gift) {
        summary = 'colive_gift';
      } else if (customMsgType == ColiveChatMessageType.emoji) {
        summary = 'colive_emoji';
      } else if (customMsgType == ColiveChatMessageType.giftAsk) {
        summary = 'colive_ask_gift';
      }
    }
    return ColiveChatConversationModel(
      id: sessionId,
      avatar: '',
      username: sessionId,
      summary: summary,
      timestamp: lastMessageTime ?? 0,
      unreadCount: unreadCount ?? 0,
      orderBy: 0,
      pin: 0,
    );
  }
}

class ColiveChatMessageType {
  static final int text = NIMMessageType.text.index;
  static final int image = NIMMessageType.image.index;
  static final int video = NIMMessageType.video.index;
  static final int custom = NIMMessageType.custom.index;
  static const int call = 101; //视频通话消息
  static const int gift = 102; //礼物消息
  static const int emoji = 103; //表情消息
  static const int giftAsk = 105; //索要礼物消息
}

class ColiveChatMessageStatus {
  /// 草稿
  static final int draft = NIMMessageStatus.draft.index;

  /// 正在发送中
  static final int sending = NIMMessageStatus.sending.index;

  /// 发送成功
  static final int success = NIMMessageStatus.success.index;

  /// 发送失败
  static final int failed = NIMMessageStatus.fail.index;

  /// 消息已读
  /// 发送消息时表示对方已看过该消息
  /// 接收消息时表示自己已读过，一般仅用于音频消息
  static final int read = NIMMessageStatus.read.index;

  /// 未读状态
  static final int unread = NIMMessageStatus.unread.index;
}

extension NIMMessageExt on NIMMessage {
  // bool get isRobot {
  //   String userId = sessionId ?? '';
  //   return userId.contains('hichat_robot_');
  // }

  ColiveChatMessageModel? get toLocalModel {
    if (messageId == null || sessionId == null) {
      return null;
    }
    final message = ColiveChatMessageModel(
      messageId: messageId ?? '',
      messageType: messageType.index,
      status: status?.index ?? NIMMessageStatus.success.index,
      isSelfSent: messageDirection == NIMMessageDirection.outgoing,
      sessionId: sessionId ?? '',
      timestamp: timestamp,
      showTime: false,
      customMessage: ColiveChatCustomMessage.empty(),
    );

    try {
      switch (messageType) {
        case NIMMessageType.text:
          if (remoteExtension != null) {
            final customType = remoteExtension!['msgType'];
            if (customType == 1) {
              // text
            } else if (customType == 2) {
              // image
              final customMessage = ColiveChatCustomMessage(
                  ColiveChatMessageType.image, content ?? '');
              return message.copyWith(
                messageType: ColiveChatMessageType.image,
                customMessage: customMessage,
              );
            } else if (customType == 3) {
              // video
              final customMessage = ColiveChatCustomMessage(
                  ColiveChatMessageType.video, content ?? '');
              return message.copyWith(
                messageType: ColiveChatMessageType.video,
                customMessage: customMessage,
              );
            }
          }
          // text
          final customMessage = ColiveChatCustomMessage(
              ColiveChatMessageType.text, content ?? '');
          return message.copyWith(
            messageType: ColiveChatMessageType.text,
            customMessage: customMessage,
          );

        case NIMMessageType.image:
          // image
          final attachment = messageAttachment as NIMImageAttachment?;
          final path = attachment?.path ?? '';
          final url = attachment?.url ?? '';
          final customMessage = ColiveChatCustomMessage(
            ColiveChatMessageType.image,
            path.isNotEmpty && File(path).existsSync() ? path : url,
          );
          return message.copyWith(
            messageType: ColiveChatMessageType.image,
            customMessage: customMessage,
          );

        case NIMMessageType.video:
          // video
          final attachment = messageAttachment as NIMVideoAttachment?;
          final path = attachment?.path ?? '';
          final url = attachment?.url ?? '';
          final customMessage = ColiveChatCustomMessage(
            ColiveChatMessageType.video,
            path.isNotEmpty && File(path).existsSync() ? path : url,
          );
          return message.copyWith(
            messageType: ColiveChatMessageType.video,
            customMessage: customMessage,
          );

        case NIMMessageType.custom:
          final attachment = messageAttachment as NIMCustomMessageAttachment?;
          final attachmentMap = attachment?.data ?? {};
          final customMsgType = int.tryParse(attachmentMap['type'].toString());
          if (customMsgType == ColiveChatMessageType.call) {
            final jsonData = attachmentMap['data'] ?? {};
            final customMessage = ColiveChatCustomMessage(
              ColiveChatMessageType.call,
              jsonEncode(jsonData),
            );
            return message.copyWith(
              messageType: ColiveChatMessageType.call,
              customMessage: customMessage,
            );
          } else if (customMsgType == ColiveChatMessageType.gift) {
            Map data = jsonDecode(attachmentMap['data']) ?? {};
            final customMessage = ColiveChatCustomMessage(
              ColiveChatMessageType.gift,
              data['giftLogo'] ?? '',
            );
            return message.copyWith(
              messageType: ColiveChatMessageType.gift,
              customMessage: customMessage,
            );
          } else if (customMsgType == ColiveChatMessageType.emoji) {
            final emojiName = attachmentMap['data']['png'] ?? '';
            final emojiPath = 'assets/emoji/$emojiName.gif';
            final customMessage = ColiveChatCustomMessage(
              ColiveChatMessageType.emoji,
              emojiPath,
            );
            return message.copyWith(
              messageType: ColiveChatMessageType.emoji,
              customMessage: customMessage,
            );
          } else if (customMsgType == ColiveChatMessageType.giftAsk) {
            final Map data = attachmentMap['data'] ?? {};
            final customMessage = ColiveChatCustomMessage(
              ColiveChatMessageType.giftAsk,
              data['giftLogo'] ?? '',
            );
            return message.copyWith(
              messageType: ColiveChatMessageType.giftAsk,
              customMessage: customMessage,
            );
          }
        default:
          ColiveLogUtil.w("toLocalModel", toString());
          break;
      }
    } catch (e) {
      ColiveLogUtil.e("toLocalModel", e.toString());
    }
    return null;
  }
}
