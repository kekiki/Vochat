import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../common/widgets/colive_shake_widget.dart';
import '../services/widgets/colive_app_scaffold.dart';
import 'colive_login_controller.dart';

class ColiveLoginPage extends GetView<ColiveLoginController> {
  const ColiveLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: controller.onAccountLogin,
                onLongPress: controller.onChangeApiServer,
                child: Image.asset(
                  Assets.imagesColiveLaunchAppIcon,
                  width: 107.pt,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: controller.onQuickLogin,
            child: Container(
              width: 345.pt,
              height: 50.pt,
              decoration: BoxDecoration(
                color: ColiveColors.primaryColor,
                borderRadius: BorderRadius.circular(25.pt),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.imagesColiveLoginQuickly, width: 24.pt),
                  SizedBox(width: 15.pt),
                  Text(
                    'colive_login_quick'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.pt,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.pt),
          Visibility(
            visible: GetPlatform.isAndroid,
            child: GestureDetector(
              onTap: controller.onGoogleLogin,
              child: Container(
                width: 345.pt,
                height: 50.pt,
                decoration: BoxDecoration(
                  color: ColiveColors.cardColor,
                  borderRadius: BorderRadius.circular(25.pt),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesColiveLoginGoogle, width: 24.pt),
                    SizedBox(width: 15.pt),
                    Text(
                      'colive_login_google'.tr,
                      style: TextStyle(
                        color: ColiveColors.primaryTextColor,
                        fontSize: 18.pt,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ).marginOnly(bottom: 20.pt),
            ),
          ),
          Visibility(
            visible: GetPlatform.isIOS,
            child: GestureDetector(
              onTap: controller.onAppleLogin,
              child: Container(
                width: 345.pt,
                height: 50.pt,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25.pt),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesColiveLoginApple, width: 24.pt),
                    SizedBox(width: 15.pt),
                    Text(
                      'colive_login_apple'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.pt,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ).marginOnly(bottom: 20.pt),
            ),
          ),
          ColiveShakeWidget(
            shakeOffset: 10,
            controller: controller.animationController,
            child: GestureDetector(
              onTap: controller.tapAgree,
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20.pt),
                  Obx(() {
                    return Visibility(
                      visible: controller.state.isAcceptPrivacyPolicyObs.value,
                      replacement: Image.asset(
                        Assets.imagesColiveCheckCircle,
                        width: 16.pt,
                        height: 16.pt,
                      ),
                      child: Image.asset(
                        Assets.imagesColiveCheckIn,
                        width: 16.pt,
                        height: 16.pt,
                        color: ColiveColors.primaryColor,
                      ),
                    );
                  }),
                  SizedBox(width: 4.pt),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${'colive_login_accept'.tr} ',
                        style: TextStyle(
                          color: ColiveColors.grayTextColor,
                          fontSize: 14.pt,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'colive_term_of_service'.tr,
                            style: TextStyle(
                              color: ColiveColors.primaryColor,
                              fontSize: 14.pt,
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.onTapTermsOfService(),
                          ),
                          TextSpan(text: ' ${'colive_and'.tr} '),
                          TextSpan(
                            text: 'colive_privacy_policy'.tr,
                            style: TextStyle(
                              color: ColiveColors.primaryColor,
                              fontSize: 14.pt,
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.onTapPrivacyPolicy(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.pt),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.pt),
        ],
      ),
    );
  }
}
