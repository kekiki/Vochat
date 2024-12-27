import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../services/models/colive_chat_message_model.dart';
import 'colive_chat_message_base_widget.dart';

class ColiveChatMessageGiftAskView extends StatelessWidget {
  const ColiveChatMessageGiftAskView({
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
      childView: _buildImageView(),
      tapUserAvatar: tapUserAvatar,
      tapAnchorAvatar: tapAnchorAvatar,
      onTapResend: onTapResend,
      onTap: onTap,
      userAvatar: userAvatar,
      anchorAvatar: anchorAvatar,
      showBackground: true,
    );
  }

  Widget _buildImageView() {
    final imagePath = messageModel.customMessage.content;
    return Row(
      children: [
        Text(
          'colive_gift_ask_for'.tr,
          style: ColiveStyles.body14w400,
        ),
        SizedBox(width: 6.pt),
        ColiveRoundImageWidget(
          imagePath,
          width: 25.pt,
          height: 25.pt,
        ),
      ],
    );
  }
}
