import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../generated/assets.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';

class ColiveAnchorAgeWidget extends StatelessWidget {
  final ColiveAnchorModel anchor;
  const ColiveAnchorAgeWidget({
    super.key,
    required this.anchor,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 16.pt,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 6.pt,
        ),
        decoration: BoxDecoration(
          color: rgba(255, 134, 170, 1),
          borderRadius: BorderRadius.circular(10.pt),
        ),
        child: Row(
          children: [
            Image.asset(
              Assets.imagesColiveGenderFemale,
              width: 10.pt,
              height: 10.pt,
            ),
            SizedBox(width: 2.pt),
            Text(
              anchor.age.toString(),
              style: ColiveStyles.body10w400.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
