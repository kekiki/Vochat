import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';

class ColiveEditNicknameDialog extends StatelessWidget {
  const ColiveEditNicknameDialog({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final lengthObs = controller.text.length.obs;
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
          Text(
            "colive_nickname".tr,
            style: ColiveStyles.title18w700,
          ),
          SizedBox(height: 14.pt),
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.symmetric(vertical: 12.pt),
            padding: EdgeInsets.symmetric(horizontal: 16.pt),
            height: 50.pt,
            decoration: BoxDecoration(
              color: ColiveColors.cardColor,
              borderRadius: BorderRadius.circular(25.pt),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'colive_nickname_place'.tr,
                hintStyle: TextStyle(color: rgba(0, 0, 0, 0.3)),
              ),
              cursorColor: ColiveColors.primaryColor,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: rgba(0, 0, 0, 1),
                fontSize: 14.pt,
              ),
              autofocus: true,
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              onChanged: (value) {
                lengthObs.value = value.length;
              },
            ),
          ),
          Obx(() {
            final text = '${lengthObs.value}/20';
            return SizedBox(
              width: double.infinity,
              child: Text(
                text,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: rgba(51, 51, 51, 0.77),
                  fontSize: 12.pt,
                ),
              ),
            );
          }),
          SizedBox(height: 32.pt),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(result: false),
                  child: Container(
                    height: 42.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColiveColors.primaryColor),
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_cancel'.tr,
                      style: ColiveStyles.title16w700.copyWith(
                        color: ColiveColors.primaryColor,
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
                      color: ColiveColors.primaryColor,
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_confirm'.tr,
                      style: ColiveStyles.title16w700
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
