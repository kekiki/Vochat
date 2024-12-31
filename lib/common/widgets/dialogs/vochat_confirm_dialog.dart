import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../../../common/adapts/vochat_colors.dart';
import '../../../common/adapts/vochat_styles.dart';

class VochatConfirmDialog extends StatelessWidget {
  const VochatConfirmDialog({
    super.key,
    this.title,
    required this.content,
    this.textAlign,
    this.confirm,
    this.cancel,
    this.onlyConfirm = false,
  });

  final String? title;
  final String content;
  final String? confirm;
  final String? cancel;
  final TextAlign? textAlign;
  final bool onlyConfirm;

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
          Visibility(
            visible: title != null,
            child: Text(
              title ?? "",
              style: VochatStyles.title18w700,
            ),
          ),
          SizedBox(height: 14.pt),
          Text(
            content,
            textAlign: textAlign ?? TextAlign.center,
            style: VochatStyles.body14w400.copyWith(
              color: VochatColors.primaryTextColor.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 32.pt),
          Visibility(
            visible: onlyConfirm,
            replacement: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(result: false),
                    child: Container(
                      height: 42.pt,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: VochatColors.primaryColor),
                        borderRadius: BorderRadius.circular(21.pt),
                      ),
                      child: Text(
                        cancel ?? 'vochat_cancel'.tr,
                        style: VochatStyles.title16w700.copyWith(
                          color: VochatColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.pt),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(result: true),
                    child: Container(
                      height: 42.pt,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: VochatColors.primaryColor,
                        borderRadius: BorderRadius.circular(21.pt),
                      ),
                      child: Text(
                        confirm ?? 'vochat_confirm'.tr,
                        style: VochatStyles.title16w700
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => Get.back(result: true),
              child: Container(
                height: 42.pt,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: VochatColors.primaryColor,
                  borderRadius: BorderRadius.circular(21.pt),
                ),
                child: Text(
                  confirm ?? 'vochat_confirm'.tr,
                  style: VochatStyles.title16w700.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
