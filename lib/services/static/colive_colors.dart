import 'package:flutter/material.dart';

Color rgba(int r, int g, int b, double a) {
  return Color.fromRGBO(r, g, b, a);
}

abstract class ColiveColors {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFFEC61D4);
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondTextColor = Color(0xFF666666);
  static const Color accentColor = Color(0xFFFF452E);
  static const Color separatorLineColor = Color(0xFFF5F6FA);
  static const Color cardColor = Color(0xFFF6F6F6);
  static const Color starColor = Color.fromARGB(255, 242, 114, 10);

  static const Color onlineColor = Color(0xFF00FF09);
  static const Color offlineColor = Color(0xFF999999);
  static const Color busyColor = Color(0xFFFF0000);

  static const Color grayTextColor = Color(0xFF898999);

  static const Color buttonNormalColor = Color(0xFFEC61D4);
  static const Color buttonDisableColor = Color(0x50EC61D4);

  static const mainGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF72E5FF), Color(0xFFFF98FA), Color(0xFFFFDF69)],
  );

  static const clearGradient = LinearGradient(
    colors: [Colors.transparent, Colors.transparent],
  );
}
