import 'package:flutter/material.dart';

/// 屏幕适配，375、812 根据设计页面大小调整
///
class VochatScreenAdapt {
  // 根据设计稿的尺寸进行适配
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static double screenWidth = 0;
  static double screenHeight = 0;
  static double statusBarHeight = 0;
  static double navigationBarHeight = 0;
  static double screenRatio = _designWidth / _designHeight;
  static Size appbarSize = const Size(375, 44);

  static double ratio = 1;

  VochatScreenAdapt._internal();

  static void initialize(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    statusBarHeight = mediaQueryData.padding.top;
    navigationBarHeight = mediaQueryData.padding.bottom;
    ratio = screenWidth / _designWidth;
    screenRatio = screenWidth / screenHeight;
    appbarSize = Size(screenWidth, 44.pt);
  }

  static double pt(double size) {
    return size * ratio;
  }
}

extension VochatScreenAdaptExt on num {
  double get pt => VochatScreenAdapt.pt(toDouble());
}
