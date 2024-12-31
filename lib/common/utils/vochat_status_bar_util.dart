import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VochatStatusBarUtil {
  VochatStatusBarUtil._internal();

  static const statusBarLightStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static const statusBarDarkStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static void transparent({bool isLight = false}) {
    final brightness = isLight ? Brightness.light : Brightness.dark;
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}
