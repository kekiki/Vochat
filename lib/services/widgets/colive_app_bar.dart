import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';

import '../../common/adapts/colive_screen_adapt.dart';

class ColiveAppBar extends StatelessWidget {
  final double? height;
  final bool isAllowBack;
  final VoidCallback? onTapBack;
  final Color appbarColor;
  final Color? backColor;
  final Widget? start;
  final Widget? center;
  final Widget? end;
  final double startSpacing;
  final double endSpacing;

  const ColiveAppBar({
    super.key,
    this.height,
    this.isAllowBack = true,
    this.onTapBack,
    this.center,
    this.start,
    this.end,
    this.backColor,
    this.appbarColor = Colors.white,
    this.startSpacing = 0,
    this.endSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ColiveScreenAdapt.screenWidth,
      height: height ?? 44.pt,
      color: appbarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: isAllowBack,
            replacement: start ?? SizedBox(width: 44.pt),
            child: SizedBox(
              width: 44.pt,
              height: 44.pt,
              child: IconButton(
                onPressed: onTapBack ?? Get.back,
                padding: EdgeInsets.zero,
                splashRadius: 20.pt,
                iconSize: 24.pt,
                icon: Image.asset(
                  Assets.imagesColiveAppbarBack,
                  width: 24.pt,
                  height: 24.pt,
                  fit: BoxFit.cover,
                  color: backColor,
                ).rtl,
              ),
            ),
          ).marginDirectional(start: startSpacing),
          center ?? const SizedBox.shrink(),
          (end ?? SizedBox(width: 44.pt)).marginDirectional(end: endSpacing),
        ],
      ),
    );
  }
}
