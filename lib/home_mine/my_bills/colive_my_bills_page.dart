import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_my_bills_controller.dart';
import 'colive_my_bills_state.dart';
import 'widgets/colive_call_records_widget.dart';
import 'widgets/colive_cash_records_widget.dart';
import 'widgets/colive_gift_records_widget.dart';
import 'widgets/colive_sys_records_widget.dart';

class ColiveMyBillsPage extends GetView<ColiveMyBillsController> {
  const ColiveMyBillsPage({super.key});

  static const pages = [
    ColiveCallRecordsWidget(),
    ColiveGiftRecordsWidget(),
    ColiveSysRecordsWidget(),
    ColiveCashRecordsWidget(),
  ];
  ColiveMyBillsState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_bills'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: Column(
        children: [
          _buildSegmentWidget(),
          Expanded(
            child: PageView.builder(
              itemCount: ColiveMyBillsType.count.index,
              controller: controller.pageController,
              onPageChanged: (value) {
                state.currentTypeObs.value = ColiveMyBillsType.values[value];
              },
              itemBuilder: (context, index) {
                return Obx(
                  () => IndexedStack(
                    index: state.currentTypeObs.value.index,
                    children: pages,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentWidget() {
    return Container(
      height: 40.pt,
      width: 330.pt,
      padding: EdgeInsets.all(5.pt),
      decoration: BoxDecoration(
        color: ColiveColors.cardColor,
        borderRadius: BorderRadius.circular(20.pt),
      ),
      child: Stack(
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: ColiveMyBillsType.count.index,
            effect: WormEffect(
              dotHeight: 30.pt,
              dotWidth: 80.pt,
              dotColor: Colors.transparent,
              activeDotColor: ColiveColors.primaryColor,
              spacing: 0,
              radius: 15.pt,
            ),
          ),
          Obx(
            () => Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyBillsType.call.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 80.pt,
                    height: 30.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'colive_call'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyBillsType.call
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyBillsType.gift.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 80.pt,
                    height: 40.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'colive_gift'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyBillsType.gift
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyBillsType.sys.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 80.pt,
                    height: 30.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'colive_sys'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyBillsType.sys
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyBillsType.cash.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 80.pt,
                    height: 30.pt,
                    padding: EdgeInsets.symmetric(horizontal: 6.pt),
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'colive_topup'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyBillsType.cash
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
