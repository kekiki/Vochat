import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../../../../common/adapts/vochat_colors.dart';
import '../../../../common/adapts/vochat_styles.dart';
import '../../../generated/assets.dart';
import 'vochat_report_controller.dart';
import 'vochat_report_state.dart';

class VochatReportDialog extends GetView<VochatReportController> {
  const VochatReportDialog({super.key});

  VochatReportState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VochatReportController());
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
            'vochat_report'.tr,
            style: VochatStyles.title18w700,
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
                color: VochatColors.separatorLineColor,
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
                      border: Border.all(color: VochatColors.primaryColor),
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'vochat_cancel'.tr,
                      style: VochatStyles.title16w700.copyWith(
                        color: VochatColors.primaryColor,
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
                      color: VochatColors.primaryColor,
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'vochat_confirm'.tr,
                      style: VochatStyles.title16w700
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
                style: VochatStyles.body16w400,
              ),
              const Spacer(),
              Visibility(
                visible: isSelected,
                replacement: Image.asset(
                  Assets.imagesVochatCheckCircle,
                  width: 20.pt,
                  height: 20.pt,
                ),
                child: Image.asset(
                  Assets.imagesVochatCheckIn,
                  width: 20.pt,
                  height: 20.pt,
                  color: VochatColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
