import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/adapts/vochat_screen_adapt.dart';

abstract class VochatDialogUtil {
  // 用bottom sheet显示，利用一下bottomSheet动画
  static Future<T?> showDialog<T>(Widget dialog, {Object? arguments}) async {
    return await Get.bottomSheet(
      Container(
        alignment: Alignment.center,
        width: VochatScreenAdapt.screenWidth,
        height: VochatScreenAdapt.screenHeight,
        child: dialog,
      ),
      settings: RouteSettings(arguments: arguments),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
}
