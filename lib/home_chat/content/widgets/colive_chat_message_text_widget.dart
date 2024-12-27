import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../../services/models/colive_chat_message_model.dart';
import '../../../services/static/colive_styles.dart';
import 'colive_chat_message_base_widget.dart';

class ColiveChatMessageTextView extends StatelessWidget {
  const ColiveChatMessageTextView({
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
      childView: _buildTextView(),
      tapUserAvatar: tapUserAvatar,
      tapAnchorAvatar: tapAnchorAvatar,
      onTap: onTap,
      userAvatar: userAvatar,
      anchorAvatar: anchorAvatar,
      onTapResend: onTapResend,
    );
  }

  Widget _buildTextView() {
    final textColor = messageModel.isSelfSent
        ? Colors.white
        : ColiveColors.primaryTextColor;
    return Container(
      constraints: BoxConstraints(maxWidth: 250.pt),
      child: SelectableText(
        messageModel.customMessage.content,
        style: ColiveStyles.body14w400.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
