import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../services/models/colive_call_model.dart';
import '../../../services/static/colive_colors.dart';

class ColiveCallingTitleBar extends StatelessWidget {
  const ColiveCallingTitleBar({
    super.key,
    required this.callModel,
    required this.callingDuration,
    required this.balance,
    this.onTapTopup,
  });

  final ColiveCallModel callModel;
  final String callingDuration;
  final int balance;
  final VoidCallback? onTapTopup;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.pt,
      padding: EdgeInsets.symmetric(horizontal: 14.pt),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                callModel.anchorNickname,
                style: ColiveStyles.title16w700.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.pt),
              Container(
                width: 64.pt,
                height: 22.pt,
                decoration: BoxDecoration(
                  color: rgba(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(11.pt),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6.pt,
                      height: 6.pt,
                      decoration: BoxDecoration(
                        color: ColiveColors.accentColor,
                        borderRadius: BorderRadius.circular(3.pt),
                      ),
                    ),
                    SizedBox(width: 6.pt),
                    Text(
                      callingDuration,
                      style: ColiveStyles.title12w700.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTapTopup,
            child: Container(
              padding: EdgeInsets.all(4.pt),
              decoration: BoxDecoration(
                color: rgba(0, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(8.pt),
              ),
              child: Row(
                children: [
                  SizedBox(width: 4.pt),
                  Image.asset(Assets.imagesColiveDiamond, width: 12.pt),
                  SizedBox(width: 4.pt),
                  Text(
                    balance.toString(),
                    style: ColiveStyles.body12w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 6.pt),
                  Image.asset(Assets.imagesColiveCallingAddDiamond,
                      width: 20.pt),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
