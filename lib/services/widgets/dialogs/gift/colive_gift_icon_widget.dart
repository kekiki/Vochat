import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';

import 'colive_gift_icon_controlller.dart';

class ColiveGiftIconWidget extends GetView<ColiveGiftIconController> {
  final String _tag;
  final String _icon;

  @override
  get controller => Get.find<ColiveGiftIconController>(tag: _tag);

  const ColiveGiftIconWidget(this._tag, this._icon, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveGiftIconController(), tag: _tag);
    return ScaleTransition(
      scale: controller.iconAnimation,
      child: ColiveRoundImageWidget(
        _icon,
        width: 44.pt,
        height: 44.pt,
        placeholder: Assets.imagesColiveChatInputGift,
        fit: BoxFit.contain,
      ),
    );
  }
}
