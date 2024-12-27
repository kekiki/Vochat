import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';

import '../../../common/widgets/colive_rotate_animation_widget.dart';
import '../../../common/widgets/colive_round_image_widget.dart';
import '../../../services/models/colive_turntable_model.dart';

class ColiveLuckyDrawResultDialog extends StatelessWidget {
  const ColiveLuckyDrawResultDialog({super.key, required this.reward});

  final ColiveTurntableRewardModel reward;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 148.pt),
          Stack(
            alignment: Alignment.center,
            children: [
              ColiveRotateAnimationWidget(
                child: Image.asset(
                  Assets.imagesColiveLuckDrawRewardLight,
                  width: 305.pt,
                  height: 305.pt,
                ),
              ).marginDirectional(start: 4.pt),
              Center(
                child: ColiveRoundImageWidget(
                  reward.img,
                  width: 80.pt,
                  height: 80.pt,
                  placeholder: Assets.imagesColiveChatInputGift,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.pt),
          IconButton(
            onPressed: Get.back,
            icon: Image.asset(
              Assets.imagesColiveDialogClose,
              width: 28.pt,
              height: 28.pt,
            ),
          ),
        ],
      ),
    );
  }
}
