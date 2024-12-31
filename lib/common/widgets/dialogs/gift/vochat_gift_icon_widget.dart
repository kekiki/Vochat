import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/widgets/vochat_round_image_widget.dart';

import '../../../generated/assets.dart';
import 'vochat_gift_icon_controlller.dart';

class VochatGiftIconWidget extends GetView<VochatGiftIconController> {
  final String _tag;
  final String _icon;

  @override
  get controller => Get.find<VochatGiftIconController>(tag: _tag);

  const VochatGiftIconWidget(this._tag, this._icon, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VochatGiftIconController(), tag: _tag);
    return ScaleTransition(
      scale: controller.iconAnimation,
      child: VochatRoundImageWidget(
        _icon,
        width: 44.pt,
        height: 44.pt,
        // placeholder: Assets.imagesVochatChatInputGift,
        fit: BoxFit.contain,
      ),
    );
  }
}
