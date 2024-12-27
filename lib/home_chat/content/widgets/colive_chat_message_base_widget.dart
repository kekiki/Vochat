import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:lottie/lottie.dart';

import '../../../common/widgets/colive_round_image_widget.dart';
import '../../../services/managers/colive_chat_extension.dart';
import '../../../services/models/colive_chat_message_model.dart';
import '../../../services/static/colive_colors.dart';
import '../../../services/static/colive_styles.dart';

class ColiveChatMessageBaseView extends StatelessWidget {
  const ColiveChatMessageBaseView({
    super.key,
    required this.messageModel,
    required this.childView,
    required this.tapUserAvatar,
    required this.tapAnchorAvatar,
    required this.onTapResend,
    this.onTap,
    this.showBackground = true,
    required this.userAvatar,
    required this.anchorAvatar,
  });

  final String userAvatar;
  final String anchorAvatar;
  final ColiveChatMessageModel messageModel;
  final Widget childView;
  final VoidCallback? tapUserAvatar;
  final VoidCallback? tapAnchorAvatar;
  final ValueChanged<ColiveChatMessageModel>? onTap;
  final ValueChanged<ColiveChatMessageModel> onTapResend;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: messageModel.showTime,
          child: Text(
            messageModel.sentTime,
            style: ColiveStyles.body12w400.copyWith(
              color: ColiveColors.primaryTextColor.withOpacity(0.6),
            ),
          ).marginOnly(bottom: 8.pt),
        ),
        GestureDetector(
          onTap: () => onTap?.call(messageModel),
          child: _buildBaseView(),
        ),
        SizedBox(height: 18.pt),
      ],
    );
  }

  Widget _buildBaseView() {
    if (messageModel.isSelfSent) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Visibility(
                visible: messageModel.status == ColiveChatMessageStatus.sending,
                replacement: Visibility(
                  visible:
                      messageModel.status == ColiveChatMessageStatus.failed,
                  child: IconButton(
                    iconSize: 34.pt,
                    padding: EdgeInsets.zero,
                    onPressed: () => onTapResend(messageModel),
                    icon: Icon(Icons.error, size: 22.pt, color: Colors.red),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.pt),
                  child: Lottie.asset(
                    Assets.animatesColiveChatMessageLoading,
                    width: 22.pt,
                    height: 22.pt,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding:
                    showBackground ? EdgeInsets.all(10.pt) : EdgeInsets.zero,
                constraints: BoxConstraints(minHeight: 32.pt),
                decoration: showBackground
                    ? BoxDecoration(
                        color: rgba(144, 138, 255, 1),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(8.pt),
                          topEnd: Radius.zero,
                          bottomStart: Radius.circular(8.pt),
                          bottomEnd: Radius.circular(8.pt),
                        ),
                      )
                    : null,
                child: childView,
              ),
            ],
          ),
          SizedBox(width: 6.pt),
          FittedBox(
            child: GestureDetector(
              onTap: tapUserAvatar,
              child: ColiveRoundImageWidget(
                userAvatar,
                width: 40.pt,
                height: 40.pt,
                isCircle: true,
                placeholder: Assets.imagesColiveAvatarUser,
              ),
            ),
          ),
          SizedBox(width: 15.pt),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15.pt),
        GestureDetector(
          onTap: tapAnchorAvatar,
          child: ColiveRoundImageWidget(
            anchorAvatar,
            width: 40.pt,
            height: 40.pt,
            isCircle: true,
            placeholder: Assets.imagesColiveAvatarAnchor,
          ),
        ),
        SizedBox(width: 6.pt),
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: showBackground ? EdgeInsets.all(10.pt) : EdgeInsets.zero,
          constraints: BoxConstraints(minHeight: 32.pt),
          decoration: showBackground
              ? BoxDecoration(
                  color: ColiveColors.cardColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.zero,
                    topEnd: Radius.circular(8.pt),
                    bottomStart: Radius.circular(8.pt),
                    bottomEnd: Radius.circular(8.pt),
                  ),
                )
              : null,
          child: childView,
        ),
      ],
    );
  }
}
