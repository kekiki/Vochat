import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

class ColiveLuckyDrawRuleDialog extends StatelessWidget {
  const ColiveLuckyDrawRuleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.pt),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.pt),
            ),
            padding: EdgeInsets.symmetric(vertical: 24.pt, horizontal: 18.pt),
            child: Column(
              children: [
                Text(
                  'colive_rule'.tr,
                  style: ColiveStyles.title18w700,
                ),
                SizedBox(height: 12.pt),
                Text(
                  'colive_rule_text1'.tr,
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.secondTextColor,
                  ),
                ),
                SizedBox(height: 12.pt),
                Text(
                  'colive_rule_text2'.tr,
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.secondTextColor,
                  ),
                ),
                SizedBox(height: 12.pt),
                Text(
                  'colive_rule_text3'.tr,
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.secondTextColor,
                  ),
                ),
                SizedBox(height: 12.pt),
                Text(
                  'colive_rule_text4_%s'
                      .trArgs([GetPlatform.isIOS ? 'Apple' : 'Google']),
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.secondTextColor,
                  ),
                ),
                SizedBox(height: 12.pt),
              ],
            ),
          ),
          SizedBox(height: 20.pt),
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
