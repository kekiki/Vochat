import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../static/colive_colors.dart';
import 'colive_gift_item_animate_controller.dart';

class ColiveGiftItemAnimateWidget
    extends GetView<ColiveGiftItemAnimateController> {
  final String _tag;
  const ColiveGiftItemAnimateWidget(this._tag, {super.key});

  @override
  get controller => Get.find<ColiveGiftItemAnimateController>(tag: _tag);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveGiftItemAnimateController(), tag: _tag);
    return Obx(() {
      if (!controller.isAnimating.value) {
        return SizedBox(width: 148.pt, height: 51.pt);
      }
      return Obx(
        () => Transform.translate(
          offset: Offset(-148.pt * controller.offset.value, 0),
          child: Container(
            width: 148.pt,
            height: 51.pt,
            decoration: BoxDecoration(
              color: rgba(0, 0, 0, 0.6),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(26.pt),
                bottomEnd: Radius.circular(26.pt),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'colive_send'.tr,
                  style:
                      ColiveStyles.body14w600.copyWith(color: Colors.white),
                ),
                SizedBox(width: 20.pt),
                ColiveRoundImageWidget(
                  controller.gift.value.logo,
                  placeholder: Assets.imagesColiveChatInputGift,
                  width: 35.pt,
                  height: 35.pt,
                ),
                SizedBox(width: 6.pt),
                ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: RichText(
                    text: TextSpan(
                      text: 'x',
                      style: ColiveStyles.body14w600.copyWith(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: controller.giftNum.value.toString(),
                          style: ColiveStyles.title22w700
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
