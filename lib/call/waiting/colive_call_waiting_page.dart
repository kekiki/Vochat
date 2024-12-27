import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/home_anchors/widgets/colive_free_call_sign.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../common/widgets/colive_marquee_widget.dart';
import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/static/colive_styles.dart';
import 'colive_call_waiting_controller.dart';
import 'colive_call_waiting_state.dart';

class ColiveCallWaitingPage extends GetView<ColiveCallWaitingController> {
  const ColiveCallWaitingPage({super.key});

  ColiveCallWaitingState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
          children: [
            Positioned.fill(
              child: ColiveRoundImageWidget(
                state.callModel.anchorAvatar,
                placeholderWidget: Container(),
                width: ColiveScreenAdapt.screenWidth,
                height: ColiveScreenAdapt.screenHeight,
              ),
            ),
            Positioned(child: Container(color: rgba(0, 0, 0, 0.2))),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 92),
                      ColiveRoundImageWidget(
                        state.callModel.anchorAvatar,
                        placeholder: Assets.imagesColiveAvatarAnchor,
                        width: 122.pt,
                        height: 122.pt,
                        isCircle: true,
                      ),
                      SizedBox(height: 20.pt),
                      Text(
                        state.callModel.anchorNickname,
                        style: ColiveStyles.title22w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.pt),
                      Visibility(
                        visible:
                            int.parse(state.callModel.conversationPrice) > 0 &&
                                !ColiveProfileManager.instance.hasFreeCallCard,
                        replacement: SizedBox(height: 24.pt),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.pt, vertical: 5.pt),
                          decoration: BoxDecoration(
                            color: rgba(0, 0, 0, 0.5),
                            borderRadius: BorderRadius.circular(12.pt),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Assets.imagesColiveDiamond,
                                width: 12.pt,
                                height: 12.pt,
                              ),
                              SizedBox(width: 4.pt),
                              Text(
                                'colive_call_price_%s_min'.trArgs(
                                    [state.callModel.conversationPrice]),
                                style: ColiveStyles.body12w400.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(flex: 174),
                      Visibility(
                        visible: state.callType == ColiveCallType.outgoing,
                        replacement: Container(
                          width: 295.pt,
                          height: 50.pt,
                          decoration: BoxDecoration(
                            color: rgba(0, 0, 0, 0.5),
                            borderRadius: BorderRadius.circular(25.pt),
                          ),
                          child: ColiveMarqueeWidget(
                            speed: 4,
                            child: Obx(
                              () => Text(
                                state.isAIBConnecting.value
                                    ? 'colive_call_connecting'.tr
                                    : 'colive_receive_call_waiting'.tr,
                                style: ColiveStyles.title18w700.copyWith(
                                  color: rgba(0, 236, 48, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          width: 190.pt,
                          height: 50.pt,
                          decoration: BoxDecoration(
                            color: rgba(0, 0, 0, 0.5),
                            borderRadius: BorderRadius.circular(25.pt),
                          ),
                          child: ColiveMarqueeWidget(
                            speed: 2,
                            child: Text(
                              'colive_send_call_waiting'.tr,
                              style: ColiveStyles.title18w700.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 60),
                      Obx(
                        () => Visibility(
                          visible: state.isAIBConnecting.value ||
                              state.callType == ColiveCallType.outgoing,
                          replacement: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: controller.onCallHangup,
                                icon: Image.asset(
                                  Assets.imagesColiveCallWaitingHangup,
                                  width: 78.pt,
                                  height: 78.pt,
                                ),
                              ),
                              SizedBox(width: 100.pt),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    onPressed: controller.onCallAgree,
                                    icon: Image.asset(
                                      Assets.imagesColiveCallWaitingAgree,
                                      width: 78.pt,
                                      height: 78.pt,
                                    ),
                                  ),
                                  ColiveFreeCallSign(
                                    visible:
                                        state.callType == ColiveCallType.aia,
                                    top: -5.pt,
                                    end: 10.pt,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: controller.onCallHangup,
                            icon: Image.asset(
                              Assets.imagesColiveCallWaitingHangup,
                              width: 78.pt,
                              height: 78.pt,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
