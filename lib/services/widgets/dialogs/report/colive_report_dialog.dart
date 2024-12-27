import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import 'colive_report_controller.dart';
import 'colive_report_state.dart';

class ColiveReportDialog extends GetView<ColiveReportController> {
  const ColiveReportDialog({super.key});

  ColiveReportState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveReportController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.pt),
      padding: EdgeInsets.symmetric(horizontal: 15.pt, vertical: 20.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.pt),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'colive_report'.tr,
            style: ColiveStyles.title18w700,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 12.pt),
            itemBuilder: (context, index) => _listItemWidget(index),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0.5,
                indent: 0,
                endIndent: 0,
                color: ColiveColors.separatorLineColor,
              );
            },
            itemCount: state.dataList.length,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(result: false),
                  child: Container(
                    height: 42.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColiveColors.primaryColor),
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_cancel'.tr,
                      style: ColiveStyles.title16w700.copyWith(
                        color: ColiveColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.pt),
              Expanded(
                child: GestureDetector(
                  onTap: controller.onTapConfirm,
                  child: Container(
                    height: 42.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColiveColors.primaryColor,
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_confirm'.tr,
                      style: ColiveStyles.title16w700
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listItemWidget(int index) {
    return Obx(() {
      final text = state.dataList[index];
      final isSelected = index == state.selectedIndex.value;
      return InkWell(
        onTap: () {
          state.selectedIndex.value = index;
        },
        child: SizedBox(
          height: 50.pt,
          child: Row(
            children: [
              Text(
                text,
                style: ColiveStyles.body16w400,
              ),
              const Spacer(),
              Visibility(
                visible: isSelected,
                replacement: Image.asset(
                  Assets.imagesColiveCheckCircle,
                  width: 20.pt,
                  height: 20.pt,
                ),
                child: Image.asset(
                  Assets.imagesColiveCheckIn,
                  width: 20.pt,
                  height: 20.pt,
                  color: ColiveColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
