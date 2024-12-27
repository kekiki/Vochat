import 'package:flutter/material.dart';

import '../../../services/managers/colive_chat_extension.dart';
import '../../../services/models/colive_chat_message_model.dart';
import 'colive_chat_message_gift_ask_widget.dart';
import 'colive_chat_message_gift_widget.dart';
import 'colive_chat_message_call_widget.dart';
import 'colive_chat_message_emoji_widget.dart';
import 'colive_chat_message_image_widget.dart';
import 'colive_chat_message_text_widget.dart';

class ColiveChatMessageWidget extends StatelessWidget {
  const ColiveChatMessageWidget({
    super.key,
    required this.message,
    this.onTapUserAvatar,
    this.onTapAnchorAvatar,
    this.onTapMessage,
    required this.userAvatar,
    required this.anchorAvatar,
    required this.onTapResend,
  });

  final String userAvatar;
  final String anchorAvatar;
  final ColiveChatMessageModel message;
  final VoidCallback? onTapUserAvatar;
  final VoidCallback? onTapAnchorAvatar;
  final ValueChanged<ColiveChatMessageModel>? onTapMessage;
  final ValueChanged<ColiveChatMessageModel> onTapResend;

  @override
  Widget build(BuildContext context) {
    if (message.messageType == ColiveChatMessageType.text) {
      return ColiveChatMessageTextView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    } else if (message.messageType == ColiveChatMessageType.image) {
      return ColiveChatMessageImageView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    } else if (message.messageType == ColiveChatMessageType.emoji) {
      return ColiveChatMessageEmojiView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    } else if (message.messageType == ColiveChatMessageType.call) {
      return ColiveChatMessageCallView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    } else if (message.messageType == ColiveChatMessageType.gift) {
      return ColiveChatMessageGiftView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    } else if (message.messageType == ColiveChatMessageType.giftAsk) {
      return ColiveChatMessageGiftAskView(
        userAvatar: userAvatar,
        anchorAvatar: anchorAvatar,
        messageModel: message,
        tapUserAvatar: onTapUserAvatar,
        tapAnchorAvatar: onTapAnchorAvatar,
        onTap: onTapMessage,
        onTapResend: onTapResend,
      );
    }
    return const SizedBox();
  }
}
