import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../static/colive_styles.dart';

class ColiveTopupToAccountDialog extends StatelessWidget {
  const ColiveTopupToAccountDialog({
    super.key,
    required this.diamonds,
    required this.vipDays,
    required this.cardNum,
  });

  final int diamonds;
  final int vipDays;
  final int cardNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.pt),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.pt, horizontal: 18.pt),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 102.pt,
            padding: EdgeInsets.symmetric(horizontal: 15.pt),
            decoration: BoxDecoration(
              color: ColiveColors.cardColor,
              borderRadius: BorderRadius.circular(8.pt),
            ),
            child: Row(
              children: [
                const Spacer(),
                Visibility(
                  visible: diamonds > 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imagesColiveDiamond,
                        width: 40.pt,
                        height: 40.pt,
                      ),
                      SizedBox(height: 6.pt),
                      Text(
                        '$diamonds',
                        style: ColiveStyles.body16w400,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: diamonds > 0 && vipDays > 0,
                  child: const Spacer(),
                ),
                Visibility(
                  visible: diamonds > 0 && vipDays > 0,
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 26.pt,
                      fontWeight: FontWeight.w300,
                      color: ColiveColors.grayTextColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: diamonds > 0 && vipDays > 0,
                  child: const Spacer(),
                ),
                Visibility(
                  visible: vipDays > 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.pt,
                        alignment: Alignment.center,
                        child: Text(
                          'colive_vip'.tr,
                          style: ColiveStyles.title22w700.copyWith(
                            color: ColiveColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.pt),
                      Text(
                        'colive_%s_days'.trArgs(['$vipDays']),
                        style: ColiveStyles.body16w400,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (diamonds > 0 || vipDays > 0) && cardNum > 0,
                  child: const Spacer(),
                ),
                Visibility(
                  visible: (diamonds > 0 || vipDays > 0) && cardNum > 0,
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 26.pt,
                      fontWeight: FontWeight.w300,
                      color: ColiveColors.grayTextColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: (diamonds > 0 || vipDays > 0) && cardNum > 0,
                  child: const Spacer(),
                ),
                Visibility(
                  visible: cardNum > 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.pt,
                        child: Center(
                          child: Image.asset(
                            Assets.imagesColiveCard,
                            width: 40.pt,
                            height: 26.pt,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.pt),
                      Text(
                        'x$cardNum',
                        style: ColiveStyles.body16w400,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(height: 32.pt),
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 42.pt,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30.pt),
              decoration: BoxDecoration(
                color: ColiveColors.primaryColor,
                borderRadius: BorderRadius.circular(21.pt),
              ),
              child: Text(
                'colive_got_it'.tr,
                style: ColiveStyles.title16w700.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
