import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_styles.dart';

class ColiveAnchorPriceWidget extends StatelessWidget {
  final ColiveAnchorModel anchor;
  const ColiveAnchorPriceWidget({
    super.key,
    required this.anchor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.imagesColiveDiamond,
          width: 14.pt,
          height: 14.pt,
        ),
        SizedBox(width: 4.pt),
        Text(
          'colive_call_price_%s_min'.trArgs([anchor.conversationPrice]),
          style: ColiveStyles.body12w400.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
