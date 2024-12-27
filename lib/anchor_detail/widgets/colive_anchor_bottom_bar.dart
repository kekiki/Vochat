import 'package:colive/home_anchors/widgets/colive_anchor_price_widget.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:get/get.dart';

import '../../home_anchors/widgets/colive_free_call_sign.dart';
import '../../services/models/colive_anchor_model.dart';

class ColiveAnchorBottomBar extends StatelessWidget {
  const ColiveAnchorBottomBar({
    super.key,
    required this.anchor,
    required this.hasFreeCallCard,
    required this.onTapChat,
    required this.onTapCall,
  });

  final ColiveAnchorModel anchor;
  final bool hasFreeCallCard;
  final VoidCallback? onTapChat;
  final VoidCallback? onTapCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.pt + ColiveScreenAdapt.navigationBarHeight,
      color: Colors.white,
      padding: EdgeInsetsDirectional.only(
        start: 14.pt,
        end: 14.pt,
        bottom: ColiveScreenAdapt.navigationBarHeight,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTapChat,
            child: Container(
              width: 127.pt,
              height: 50.pt,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: rgba(238, 238, 238, 1)),
                borderRadius: BorderRadiusDirectional.circular(25.pt),
              ),
              child: Text(
                'colive_chat'.tr,
                style: ColiveStyles.body14w600,
              ),
            ),
          ),
          SizedBox(width: 10.pt),
          Expanded(
            child: GestureDetector(
              onTap: onTapCall,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 50.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: ColiveColors.mainGradient,
                      borderRadius: BorderRadiusDirectional.circular(25.pt),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'colive_video_call'.tr,
                          style: ColiveStyles.body14w600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Visibility(
                          visible: !hasFreeCallCard,
                          child: ColiveAnchorPriceWidget(anchor: anchor),
                        ),
                      ],
                    ),
                  ),
                  const ColiveFreeCallSign(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
