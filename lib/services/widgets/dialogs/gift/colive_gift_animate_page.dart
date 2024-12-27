import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import 'colive_gift_animate_controller.dart';

class ColiveGiftAnimatePage extends GetView<ColiveGiftAnimateController> {
  const ColiveGiftAnimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveGiftAnimateController());
    return Stack(
      children: [
        SizedBox(
          width: ColiveScreenAdapt.screenWidth,
          height: ColiveScreenAdapt.screenHeight,
          child: SVGAImage(
            controller.animateController,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.topWidget,
              SizedBox(height: 15.pt),
              controller.bottomWidget,
              SizedBox(height: 340.pt),
            ],
          ),
        ),
      ],
    );
  }
}
