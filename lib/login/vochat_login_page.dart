import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../common/adapts/vochat_colors.dart';
import '../common/generated/assets.dart';
import '../common/widgets/vochat_app_scaffold.dart';
import '../common/widgets/vochat_shake_widget.dart';
import 'vochat_login_controller.dart';

class VochatLoginPage extends GetView<VochatLoginController> {
  const VochatLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VochatAppScaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onLongPress: controller.onChangeApiServer,
                child: Image.asset(
                  Assets.imagesVochatLaunchAppIcon,
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
                gradient: VochatColors.mainGradient,
                borderRadius: BorderRadius.circular(25.pt),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.imagesVochatLoginQuickly, width: 24.pt),
                  SizedBox(width: 15.pt),
                  Text(
                    'vochat_login_quick'.tr,
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
                  color: VochatColors.cardColor,
                  borderRadius: BorderRadius.circular(25.pt),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesVochatLoginGoogle, width: 24.pt),
                    SizedBox(width: 15.pt),
                    Text(
                      'vochat_login_google'.tr,
                      style: TextStyle(
                        color: VochatColors.primaryTextColor,
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
                    Image.asset(Assets.imagesVochatLoginApple, width: 24.pt),
                    SizedBox(width: 15.pt),
                    Text(
                      'vochat_login_apple'.tr,
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
          _buildAgreementWidget(),
          SizedBox(height: 20.pt),
        ],
      ),
    );
  }

  Widget _buildAgreementWidget() {
    final fullText = 'vochat_login_agreement'.tr;
    final agreementText = 'vochat_user_agreement'.tr;
    final privacyText = 'vochat_privacy_policy'.tr;
    final agreementIndex = fullText.indexOf(agreementText);
    final privacyIndex = fullText.indexOf(privacyText);
    final startText = fullText.substring(0, agreementIndex);
    final middleText =
        fullText.substring(agreementIndex + agreementText.length, privacyIndex);

    return VochatShakeWidget(
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
                  Assets.imagesVochatCheckCircle,
                  width: 16.pt,
                  height: 16.pt,
                ),
                child: Image.asset(
                  Assets.imagesVochatCheckIn,
                  width: 16.pt,
                  height: 16.pt,
                  color: VochatColors.primaryColor,
                ),
              );
            }),
            SizedBox(width: 4.pt),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: startText,
                  style: TextStyle(
                    color: VochatColors.grayTextColor,
                    fontSize: 14.pt,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: agreementText,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: VochatColors.primaryColor,
                        decorationColor: VochatColors.primaryColor,
                        fontSize: 14.pt,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => controller.onTapTermsOfService(),
                    ),
                    TextSpan(text: middleText),
                    TextSpan(
                      text: privacyText,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: VochatColors.primaryColor,
                        color: VochatColors.primaryColor,
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
    );
  }
}
