import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../static/colive_colors.dart';
import '../static/colive_styles.dart';

class ColiveEmptyWidget extends StatelessWidget {
  const ColiveEmptyWidget({
    super.key,
    required this.text,
    this.height,
    this.imageSize,
  });

  final String text;
  final double? height;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 400.pt,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesColiveIconNoData,
            width: imageSize ?? 122.pt,
            height: imageSize ?? 122.pt,
          ),
          SizedBox(height: 15.pt),
          Text(
            text,
            style: ColiveStyles.body14w400.copyWith(
              color: rgba(153, 153, 153, 1),
            ),
          ),
        ],
      ),
    );
  }
}
