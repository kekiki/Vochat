import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import '../common/generated/assets.dart';
import 'vochat_splash_controller.dart';

class VochatSplashPage extends StatelessWidget {
  const VochatSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VochatSplashController>(
      init: VochatSplashController(),
      assignId: true,
      builder: (logic) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              Assets.imagesVochatLaunchAppIcon,
              width: 107.pt,
            ),
          ),
        );
      },
    );
  }
}
