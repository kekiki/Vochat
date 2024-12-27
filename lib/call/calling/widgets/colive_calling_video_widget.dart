import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_call_invitation_manager.dart';

import '../colive_call_calling_controller.dart';
import 'colive_calling_aia_widget.dart';

class ColiveCallingVideoWidget extends StatelessWidget {
  const ColiveCallingVideoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ColiveCallCallingController>();
    final state = controller.state;
    return Stack(
      children: [
        Positioned.fill(
          child: StreamBuilder<Widget>(
            initialData: controller.initFullScreenPlaceholder,
            stream: controller.fullScreenWidgetStream,
            builder: (context, snapshot) {
              return snapshot.requireData;
            },
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: state.callType == ColiveCallType.aia,
            child: ColiveCallingAiaWidget(
              videoUri: state.callModel.url,
              onPlayProgress: controller.onAiaPlayProgress,
              onPlayEnd: controller.onAiaPlayEnd,
              onPlayFailed: controller.onAiaPlayFailed,
            ),
          ),
        ),
        PositionedDirectional(
          start: 60.pt,
          end: 60.pt,
          bottom: 30.pt + ColiveScreenAdapt.navigationBarHeight,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    final isStartCamera = state.isCameraEnableObs.value;
                    final image = isStartCamera
                        ? Assets.imagesColiveCallingCameraEnable
                        : Assets.imagesColiveCallingCameraDisable;
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: controller.onTapCamera,
                      icon: Image.asset(
                        image,
                        width: 54.pt,
                        height: 54.pt,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                  Obx(() {
                    final isSpeakerEnable = state.isSpeakerObs.value;
                    final image = isSpeakerEnable
                        ? Assets.imagesColiveCallingSpeakerEnable
                        : Assets.imagesColiveCallingSpeakerDisable;
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: controller.onTapSpeaker,
                      icon: Image.asset(
                        image,
                        width: 54.pt,
                        height: 54.pt,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                  Obx(() {
                    final isVoiceEnable = state.isVoiceEnableObs.value;
                    final image = isVoiceEnable
                        ? Assets.imagesColiveCallingVoiceEnable
                        : Assets.imagesColiveCallingVoiceDisable;
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: controller.onTapVoice,
                      icon: Image.asset(
                        image,
                        width: 54.pt,
                        height: 54.pt,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 20.pt),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: controller.onTapFlip,
                    icon: Image.asset(
                      Assets.imagesColiveCallingCameraChange,
                      width: 54.pt,
                      height: 54.pt,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: controller.onTapHangup,
                    icon: Image.asset(
                      Assets.imagesColiveCallWaitingHangup,
                      width: 65.pt,
                      height: 65.pt,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: controller.onTapGift,
                    icon: Image.asset(
                      Assets.imagesColiveCallingGift,
                      width: 54.pt,
                      height: 54.pt,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => PositionedDirectional(
            top: state.smallScreenTop.value,
            end: state.smallScreenEnd.value,
            width: state.smallScreenWidth,
            height: state.smallScreenHeight,
            child: GestureDetector(
              onTap: controller.onTapSmallPreview,
              onPanUpdate: (details) => controller.updateOffsets(details.delta),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.pt),
                child: StreamBuilder<Widget>(
                  initialData: controller.initSmallScreenPlaceholder,
                  stream: controller.smallScreenWidgetStream,
                  builder: (context, snapshot) {
                    return snapshot.requireData;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
