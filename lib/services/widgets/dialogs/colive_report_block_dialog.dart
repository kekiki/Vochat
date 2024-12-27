import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/models/colive_anchor_model.dart';
import 'package:colive/services/repositories/colive_anchor_repository.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import 'colive_dialog_util.dart';
import 'report/colive_report_dialog.dart';

class ColiveReportBlockDialog extends StatelessWidget {
  const ColiveReportBlockDialog({super.key, required this.anchor});

  final ColiveAnchorModel anchor;

  void _onTapReport() {
    Get.back();
    ColiveDialogUtil.showDialog(
      const ColiveReportDialog(),
      arguments: anchor,
    );
  }

  void _onTapBlock() {
    Get.back();
    final repository = Get.find<ColiveAnchorRepository>();
    repository.requestBlock(anchor: anchor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.pt, horizontal: 12.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(16.pt),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _onTapReport,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'colive_report'.tr,
                style: ColiveStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: ColiveColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: _onTapBlock,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                anchor.isToBlock
                    ? 'colive_cancel_block'.tr
                    : 'colive_block'.tr,
                style: ColiveStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: ColiveColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'colive_cancel'.tr,
                style: ColiveStyles.body14w600.copyWith(
                  color: ColiveColors.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: ColiveScreenAdapt.navigationBarHeight,
          ),
        ],
      ),
    );
  }
}
