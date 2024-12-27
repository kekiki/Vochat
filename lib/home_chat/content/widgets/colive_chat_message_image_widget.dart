import 'package:colive/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';

import '../../../services/models/colive_chat_message_model.dart';
import 'colive_chat_message_base_widget.dart';

class ColiveChatMessageImageView extends StatelessWidget {
  const ColiveChatMessageImageView({
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
      showBackground: false,
    );
  }

  Widget _buildImageView() {
    final imagePath = messageModel.customMessage.content;
    final isLocal = !imagePath.isURL;
    return ColiveRoundImageWidget(
      imagePath,
      isLocalImage: isLocal,
      width: 100.pt,
      height: 120.pt,
      placeholder: Assets.imagesColiveAvatarAnchor,
      borderRadius: BorderRadiusDirectional.circular(8.pt),
    );
  }
}
