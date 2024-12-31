import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import 'vochat_gift_animate_controller.dart';

class VochatGiftAnimatePage extends GetView<VochatGiftAnimateController> {
  const VochatGiftAnimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VochatGiftAnimateController());
    return Stack(
      children: [
        SizedBox(
          width: VochatScreenAdapt.screenWidth,
          height: VochatScreenAdapt.screenHeight,
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
