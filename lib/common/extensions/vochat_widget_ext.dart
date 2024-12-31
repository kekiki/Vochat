import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension VochatWidgetExt on Widget {
  Widget get rtl {
    final code = Get.locale?.languageCode ?? 'en';
    if (rtlLanguages.contains(code)) {
      return Transform.scale(scaleX: -1, scaleY: 1, child: this);
    }
    return this;
  }

  Widget marginDirectional({
    double start = 0.0,
    double top = 0.0,
    double end = 0.0,
    double bottom = 0.0,
  }) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: top,
        start: start,
        end: end,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
