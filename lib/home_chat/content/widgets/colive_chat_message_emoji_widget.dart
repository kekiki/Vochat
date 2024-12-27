import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../../services/models/colive_chat_message_model.dart';
import 'colive_chat_message_base_widget.dart';

class ColiveChatMessageEmojiView extends StatelessWidget {
  const ColiveChatMessageEmojiView({
    super.key,
    required this.messageModel,
    this.tapUserAvatar,
    this.tapAnchorAvatar,
    this.onTap,
    required this.userAvatar,
    required this.anchorAvatar,
    required this.onTapResend,
  });

  final String userAvatar;
  final String anchorAvatar;
  final ColiveChatMessageModel messageModel;
  final VoidCallback? tapUserAvatar;
  final VoidCallback? tapAnchorAvatar;
  final ValueChanged<ColiveChatMessageModel>? onTap;
  final ValueChanged<ColiveChatMessageModel> onTapResend;

  @override
  Widget build(BuildContext context) {
    return ColiveChatMessageBaseView(
      messageModel: messageModel,
      childView: _buildEmojiView(),
      tapUserAvatar: tapUserAvatar,
      tapAnchorAvatar: tapAnchorAvatar,
      onTapResend: onTapResend,
      onTap: onTap,
      userAvatar: userAvatar,
      anchorAvatar: anchorAvatar,
      showBackground: false,
    );
  }

  Widget _buildEmojiView() {
    return GifView.asset(
      messageModel.customMessage.content,
      repeat: ImageRepeat.repeat,
      frameRate: 5,
      width: 80.pt,
      height: 80.pt,
    );
  }
}
