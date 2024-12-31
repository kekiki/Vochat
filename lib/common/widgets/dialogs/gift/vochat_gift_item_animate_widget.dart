import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/widgets/vochat_round_image_widget.dart';
import '../../../../common/adapts/vochat_colors.dart';
import '../../../../common/adapts/vochat_styles.dart';
import '../../../generated/assets.dart';
import 'vochat_gift_item_animate_controller.dart';

class VochatGiftItemAnimateWidget
    extends GetView<VochatGiftItemAnimateController> {
  final String _tag;
  const VochatGiftItemAnimateWidget(this._tag, {super.key});

  @override
  get controller => Get.find<VochatGiftItemAnimateController>(tag: _tag);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VochatGiftItemAnimateController(), tag: _tag);
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
                  'vochat_send'.tr,
                  style: VochatStyles.body14w600.copyWith(color: Colors.white),
                ),
                SizedBox(width: 20.pt),
                VochatRoundImageWidget(
                  controller.gift.value.logo,
                  // placeholder: Assets.imagesVochatChatInputGift,
                  width: 35.pt,
                  height: 35.pt,
                ),
                SizedBox(width: 6.pt),
                ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: RichText(
                    text: TextSpan(
                      text: 'x',
                      style: VochatStyles.body14w600.copyWith(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: controller.giftNum.value.toString(),
                          style: VochatStyles.title22w700
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
