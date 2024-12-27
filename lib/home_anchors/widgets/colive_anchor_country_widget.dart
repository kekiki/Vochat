import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../common/widgets/colive_round_image_widget.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';

class ColiveAnchorCountryWidget extends StatelessWidget {
  final ColiveAnchorModel anchor;
  const ColiveAnchorCountryWidget({
    super.key,
    required this.anchor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.pt,
      padding: EdgeInsets.symmetric(horizontal: 6.pt),
      decoration: BoxDecoration(
        color: rgba(0, 0, 0, 0.5),
        borderRadius: BorderRadius.circular(10.pt),
      ),
      child: Row(
        children: [
          ColiveRoundImageWidget(
            anchor.countryIcon,
            width: 13.pt,
            height: 13.pt,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 2.pt),
          Text(
            anchor.country,
            style: ColiveStyles.body10w400.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
