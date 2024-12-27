import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/call/calling/widgets/colive_calling_title_bar.dart';

import '../../common/adapts/colive_screen_adapt.dart';
import '../../common/widgets/colive_round_image_widget.dart';
import '../../services/widgets/dialogs/gift/colive_gift_animate_page.dart';
import 'colive_call_calling_controller.dart';
import 'colive_call_calling_state.dart';
import 'widgets/colive_calling_video_widget.dart';

class ColiveCallCallingPage extends GetView<ColiveCallCallingController> {
  const ColiveCallCallingPage({super.key});

  ColiveCallCallingState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ColiveRoundImageWidget(
                state.callModel.anchorAvatar,
                placeholderWidget: Container(),
                width: ColiveScreenAdapt.screenWidth,
                height: ColiveScreenAdapt.screenHeight,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(),
              ),
            ),
            const Positioned.fill(
              child: ColiveCallingVideoWidget(),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: ColiveScreenAdapt.statusBarHeight),
                child: Obx(
                  () => ColiveCallingTitleBar(
                    callModel: state.callModel,
                    callingDuration: state.callingDurationObs.value,
                    balance: state.profileObs.value.diamonds,
                    onTapTopup: controller.onTapTopup,
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: ColiveGiftAnimatePage(),
            ),
          ],
        ),
      ),
    );
  }
}
