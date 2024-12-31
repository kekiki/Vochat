import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/services/models/vochat_anchor_model.dart';
import 'package:vochat/services/repositories/vochat_anchor_repository.dart';

import '../../../common/adapts/vochat_colors.dart';
import '../../../common/adapts/vochat_styles.dart';
import 'vochat_dialog_util.dart';
import 'report/vochat_report_dialog.dart';

class VochatReportBlockDialog extends StatelessWidget {
  const VochatReportBlockDialog({super.key, required this.anchor});

  final VochatAnchorModel anchor;

  void _onTapReport() {
    Get.back();
    VochatDialogUtil.showDialog(
      const VochatReportDialog(),
      arguments: anchor,
    );
  }

  void _onTapBlock() {
    Get.back();
    final repository = Get.find<VochatAnchorRepository>();
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
                'vochat_report'.tr,
                style: VochatStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: VochatColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: _onTapBlock,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                anchor.isToBlock ? 'vochat_cancel_block'.tr : 'vochat_block'.tr,
                style: VochatStyles.body14w600,
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: VochatColors.separatorLineColor,
          ),
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 60.pt,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'vochat_cancel'.tr,
                style: VochatStyles.body14w600.copyWith(
                  color: VochatColors.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: VochatScreenAdapt.navigationBarHeight,
          ),
        ],
      ),
    );
  }
}
