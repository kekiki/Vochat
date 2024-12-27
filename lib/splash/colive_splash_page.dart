import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'colive_splash_controller.dart';

class ColiveSplashPage extends StatelessWidget {
  const ColiveSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColiveSplashController>(
      init: ColiveSplashController(),
      assignId: true,
      builder: (logic) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              Assets.imagesColiveLaunchAppIcon,
              width: 107.pt,
            ),
          ),
        );
      },
    );
  }
}
