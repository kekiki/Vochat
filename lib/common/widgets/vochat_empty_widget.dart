import 'package:flutter/material.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../../common/adapts/vochat_colors.dart';
import '../../common/adapts/vochat_styles.dart';
import '../generated/assets.dart';

class VochatEmptyWidget extends StatelessWidget {
  const VochatEmptyWidget({
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
            Assets.imagesVochatIconNoData,
            width: imageSize ?? 122.pt,
            height: imageSize ?? 122.pt,
          ),
          SizedBox(height: 15.pt),
          Text(
            text,
            style: VochatStyles.body14w400.copyWith(
              color: rgba(153, 153, 153, 1),
            ),
          ),
        ],
      ),
    );
  }
}
