import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:colive/services/static/colive_colors.dart';
import '../../../home_anchors/widgets/colive_free_call_sign.dart';
import '../../../services/static/colive_styles.dart';
import '../colive_chat_content_state.dart';

class ColiveChatInputWidget extends StatelessWidget {
  const ColiveChatInputWidget({
    super.key,
    required this.placeholder,
    required this.conversationId,
    required this.textEditingNode,
    required this.textEditingController,
    required this.inputType,
    required this.enableSend,
    this.onTapSend,
    this.onTapEmoji,
    this.onTapImage,
    this.onTapCall,
    this.onTapGift,
    this.onTapTextField,
  });

  final String conversationId;
  final String placeholder;
  final TextEditingController textEditingController;
  final FocusNode textEditingNode;
  final ColiveChatInputType inputType;
  final bool enableSend;
  final VoidCallback? onTapSend;
  final VoidCallback? onTapEmoji;
  final VoidCallback? onTapImage;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapGift;
  final VoidCallback? onTapTextField;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 58.pt),
            padding: EdgeInsets.symmetric(vertical: 10.pt),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(
                  visible:
                      ColiveChatManager.isCustomerServiceId(conversationId),
                  replacement: SizedBox(width: 12.pt),
                  child: GestureDetector(
                    onTap: onTapImage,
                    child: Container(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 12.pt),
                      child: Image.asset(
                        Assets.imagesColiveChatInputPhoto,
                        width: 32.pt,
                        height: 32.pt,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 38.pt),
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 4.pt, horizontal: 14.pt),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19.pt),
                      color: ColiveColors.cardColor,
                      border: Border.all(color: rgba(242, 244, 246, 1)),
                    ),
                    child: TextField(
                      onTap: onTapTextField,
                      focusNode: textEditingNode,
                      controller: textEditingController,
                      cursorColor: ColiveColors.primaryColor,
                      maxLines: 5,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) => onTapSend!(),
                      keyboardType: TextInputType.multiline,
                      style: ColiveStyles.body14w400,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: placeholder,
                        hintStyle: ColiveStyles.body12w400.copyWith(
                          color: rgba(153, 153, 153, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapSend,
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 6.pt),
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 12.pt),
                    child: Opacity(
                      opacity: enableSend ? 1.0 : 0.5,
                      child: Image.asset(
                        Assets.imagesColiveChatIconSend,
                        width: 28.pt,
                      ).rtl,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !ColiveChatManager.isCustomerServiceId(conversationId),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: onTapEmoji,
                      icon: Image.asset(
                        Assets.imagesColiveChatInputEmoji,
                        width: 32.pt,
                        height: 32.pt,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: onTapImage,
                      icon: Image.asset(
                        Assets.imagesColiveChatInputPhoto,
                        width: 32.pt,
                        height: 32.pt,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          onPressed: onTapCall,
                          icon: Image.asset(
                            Assets.imagesColiveChatInputCall,
                            width: 32.pt,
                            height: 32.pt,
                          ),
                        ),
                        ColiveFreeCallSign(top: -5.pt, end: 10.pt),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: onTapGift,
                      icon: Image.asset(
                        Assets.imagesColiveChatInputGift,
                        width: 32.pt,
                        height: 32.pt,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
