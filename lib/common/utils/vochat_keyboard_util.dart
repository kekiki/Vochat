import 'package:flutter/material.dart';

class VochatKeyboardUtil {
  VochatKeyboardUtil._internal();

  static hideKeyboard(BuildContext? context) {
    if (context == null) {
      return;
    }
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
