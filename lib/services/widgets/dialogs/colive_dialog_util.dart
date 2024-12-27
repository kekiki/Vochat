import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/adapts/colive_screen_adapt.dart';

abstract class ColiveDialogUtil {
  // 用bottom sheet显示，利用一下bottomSheet动画
  static Future<T?> showDialog<T>(Widget dialog, {Object? arguments}) async {
    return await Get.bottomSheet(
      Container(
        alignment: Alignment.center,
        width: ColiveScreenAdapt.screenWidth,
        height: ColiveScreenAdapt.screenHeight,
        child: dialog,
      ),
      settings: RouteSettings(arguments: arguments),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
}
