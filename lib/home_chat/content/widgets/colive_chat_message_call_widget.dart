import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../../services/models/colive_chat_message_model.dart';
import '../../../services/static/colive_styles.dart';
import 'colive_chat_message_base_widget.dart';

class ColiveChatMessageCallView extends StatelessWidget {
  const ColiveChatMessageCallView({
    super.key,
    required this.messageModel,
    this.tapUserAvatar,
    this.tapAnchorAvatar,
    required this.onTapResend,
    this.onTap,
    required this.userAvatar,
    required this.anchorAvatar,
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
      childView: _buildCallView(),
      tapUserAvatar: tapUserAvatar,
      tapAnchorAvatar: tapAnchorAvatar,
      onTapResend: onTapResend,
      onTap: onTap,
      userAvatar: userAvatar,
      anchorAvatar: anchorAvatar,
    );
  }

  Widget _buildCallView() {
    final textColor =
        messageModel.isSelfSent ? Colors.white : ColiveColors.primaryTextColor;
    final data = jsonDecode(messageModel.customMessage.content);
    final callStatus = data['callStatus'];
    final callTime = data['callTime'];

    String text = '';
    if (callStatus == 1) {
      //Reject
      text = 'colive_declined'.tr;
    } else if (callStatus == 2) {
      //Cancel
      text = 'colive_canceled'.tr;
    } else if (callStatus == 3) {
      //Missed
      text = 'colive_missed'.tr;
    } else if (callStatus == 4) {
      //Call duration
      final duration = ColiveFormatUtil.durationToTime(
        callTime,
        isShowHour: false,
      );
      text = '${'colive_duration'.tr} $duration';
    }

    return Container(
      constraints: BoxConstraints(maxWidth: 250.pt),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.imagesColiveChatMessageCall,
            width: 20.pt,
            height: 20.pt,
            color: textColor,
          ),
          SizedBox(width: 8.pt),
          SelectableText(
            text,
            style: ColiveStyles.body14w400.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
