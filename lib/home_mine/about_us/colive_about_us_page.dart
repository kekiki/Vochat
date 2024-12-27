import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_about_us_controller.dart';

class ColiveAboutUsPage extends GetView<ColiveAboutUsController> {
  const ColiveAboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_about_us'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 80.pt),
          Image.asset(
            Assets.imagesColiveLaunchAppIcon,
            width: 107.pt,
          ),
          SizedBox(height: 10.pt),
          Obx(
            () => Text(
              controller.versionObs.value,
              style: ColiveStyles.body10w400.copyWith(
                color: ColiveColors.grayTextColor,
              ),
            ),
          ),
          SizedBox(height: 120.pt),
          Container(
            height: 120.pt,
            padding: EdgeInsets.symmetric(horizontal: 15.pt),
            margin: EdgeInsets.symmetric(horizontal: 15.pt),
            decoration: BoxDecoration(
              color: ColiveColors.cardColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.pt),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.onTapPrivacyPolicy,
                    child: Row(
                      children: [
                        Text(
                          'colive_privacy_policy'.tr,
                          style: ColiveStyles.body14w400,
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.imagesColiveMineArrowRight,
                          width: 14.pt,
                          height: 14.pt,
                        ).rtl,
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: rgba(0, 0, 0, 0.05),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.onTapTermsOfService,
                    child: Row(
                      children: [
                        Text(
                          'colive_term_of_service'.tr,
                          style: ColiveStyles.body14w400,
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.imagesColiveMineArrowRight,
                          width: 14.pt,
                          height: 14.pt,
                        ).rtl,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
