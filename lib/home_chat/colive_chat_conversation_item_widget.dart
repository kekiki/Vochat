import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../common/widgets/colive_round_image_widget.dart';
import '../common/utils/colive_format_util.dart';
import '../services/managers/colive_chat_manager.dart';
import '../services/models/colive_chat_conversation_model.dart';
import '../services/static/colive_colors.dart';
import '../services/static/colive_styles.dart';

class ColiveChatConversationItemWidget extends StatelessWidget {
  final ColiveChatConversationModel conversation;
  final ValueChanged<ColiveChatConversationModel> onTapPin;
  final ValueChanged<ColiveChatConversationModel> onTapDelete;

  const ColiveChatConversationItemWidget({
    super.key,
    required this.conversation,
    required this.onTapPin,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(conversation),
      isDraggable: !conversation.isCustomerService,
      trailingActions: [
        SwipeAction(
          color: ColiveColors.accentColor,
          widthSpace: 80.pt,
          onTap: (CompletionHandler handler) async {
            onTapDelete.call(conversation);
          },
          content: Center(
            child: Image.asset(
              Assets.imagesColiveSearchHistoryDelete,
              width: 24.pt,
              color: Colors.white,
            ),
          ),
        ),
        SwipeAction(
          color: rgba(91, 114, 225, 1),
          widthSpace: 80.pt,
          onTap: (CompletionHandler handler) async {
            onTapPin.call(conversation);
          },
          content: Center(
            child: Image.asset(
              conversation.isPin
                  ? Assets.imagesColiveChatConversationUnpin
                  : Assets.imagesColiveChatConversationPin,
              width: 24.pt,
              color: Colors.white,
            ),
          ),
        ),
      ],
      child: Container(
        height: 80.pt,
        padding: EdgeInsets.symmetric(horizontal: 15.pt, vertical: 10.pt),
        decoration: BoxDecoration(
          color: conversation.isPin ? ColiveColors.cardColor : Colors.white,
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final nickname = conversation.isCustomerService
        ? ColiveChatManager.customerServiceName.tr
        : conversation.username ?? '';
    var summary = conversation.summary ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAvatar(),
        SizedBox(width: 10.pt),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    nickname,
                    style: ColiveStyles.title14w600.copyWith(
                      color: ColiveColors.primaryTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Visibility(
                visible: summary.isNotEmpty,
                child: Text(
                  summary.tr,
                  style: ColiveStyles.body12w400.copyWith(
                    color: ColiveColors.primaryTextColor.withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).marginOnly(top: 4.pt),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.pt),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ColiveFormatUtil.millisecondsToTime(conversation.timestamp),
              style: ColiveStyles.body12w400.copyWith(
                color: ColiveColors.primaryTextColor.withOpacity(0.6),
                height: 1.4,
              ),
            ),
            Visibility(
              visible: conversation.unreadCount > 0,
              child: Container(
                alignment: Alignment.center,
                height: 16.pt,
                constraints: BoxConstraints(minWidth: 18.pt),
                decoration: BoxDecoration(
                  color: ColiveColors.accentColor,
                  borderRadius: BorderRadius.circular(8.pt),
                ),
                child: Text(
                  conversation.unreadCount > 0
                      ? conversation.unreadCount.toString()
                      : "",
                  style: ColiveStyles.body12w400.copyWith(color: Colors.white),
                ),
              ).marginOnly(top: 6.pt),
            )
          ],
        )
      ],
    );
  }

  Widget _buildAvatar() {
    return ColiveRoundImageWidget(
      conversation.isCustomerService
          ? Assets.imagesColiveAvatarCustomerService
          : conversation.avatar ?? "",
      width: 50.pt,
      height: 50.pt,
      isCircle: true,
      placeholder: Assets.imagesColiveAvatarAnchor,
    );
  }
}
