import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../common/widgets/colive_button_widget.dart';
import '../../services/static/colive_styles.dart';

class ColiveAccountLoginDialog extends StatelessWidget {
  const ColiveAccountLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = '';
    String password = '';
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 375.pt,
        padding: EdgeInsets.all(15.pt),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.pt),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Account Login',
              style: ColiveStyles.title18w700,
            ),
            SizedBox(height: 15.pt),
            Container(
              width: 339.pt,
              height: 46.pt,
              padding: EdgeInsets.symmetric(horizontal: 12.pt),
              decoration: BoxDecoration(
                color: ColiveColors.cardColor,
                borderRadius: BorderRadius.circular(6.pt),
              ),
              child: TextField(
                maxLines: 1,
                autofocus: true,
                cursorColor: ColiveColors.primaryColor,
                keyboardType: TextInputType.number,
                style: ColiveStyles.body14w400,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'UserId',
                  hintStyle: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  userId = value;
                },
              ),
            ),
            SizedBox(height: 10.pt),
            Container(
              width: 339.pt,
              height: 46.pt,
              padding: EdgeInsets.symmetric(horizontal: 12.pt),
              decoration: BoxDecoration(
                color: ColiveColors.cardColor,
                borderRadius: BorderRadius.circular(6.pt),
              ),
              child: TextField(
                maxLines: 1,
                cursorColor: ColiveColors.primaryColor,
                keyboardType: TextInputType.text,
                style: ColiveStyles.body14w400,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  password = value;
                },
                onSubmitted: (value) {
                  Get.back(
                    result: {
                      'userId': userId,
                      'password': password,
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 15.pt),
            ColiveButtonWidget(
              onPressed: () {
                Get.back(
                  result: {
                    'userId': userId,
                    'password': password,
                  },
                );
              },
              width: 200.pt,
              height: 44.pt,
              borderRadius: 22.pt,
              backgroundColor: ColiveColors.primaryColor,
              child: Text(
                'Login',
                style: ColiveStyles.title16w700.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
