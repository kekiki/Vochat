import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

class ColiveHomeChatMoreDialog extends StatelessWidget {
  const ColiveHomeChatMoreDialog({
    super.key,
    required this.onTapIgnoreUnread,
    required this.onTapDeleteAll,
  });

  final VoidCallback onTapIgnoreUnread;
  final VoidCallback onTapDeleteAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.pt, horizontal: 12.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(16.pt),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              onTapIgnoreUnread();
            },
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'colive_ignore_unread'.tr,
                style: ColiveStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: ColiveColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              onTapDeleteAll();
            },
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'colive_delete_all'.tr,
                style: ColiveStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: ColiveColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'colive_cancel'.tr,
                style: ColiveStyles.body14w600.copyWith(
                  color: ColiveColors.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: ColiveScreenAdapt.navigationBarHeight,
          ),
        ],
      ),
    );
  }
}
