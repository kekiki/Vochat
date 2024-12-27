import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_follow_widget.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_popular_widget.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:lottie/lottie.dart';

import '../common/widgets/colive_keep_alive_widget.dart';
import '../services/widgets/colive_app_bar.dart';
import '../services/widgets/colive_app_scaffold.dart';
import '../services/static/colive_styles.dart';
import 'colive_home_anchors_controller.dart';
import 'colive_home_anchors_state.dart';
import 'widgets/colive_anchor_tab_indicator.dart';

class ColiveHomeAnchorsPage extends GetView<ColiveHomeAnchorsController> {
  const ColiveHomeAnchorsPage({super.key});

  ColiveHomeAnchorsState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        isAllowBack: false,
        startSpacing: 5.pt,
        start: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerHeight: 0,
          unselectedLabelColor: ColiveColors.primaryTextColor.withOpacity(0.6),
          unselectedLabelStyle: ColiveStyles.title18w700,
          labelColor: ColiveColors.primaryTextColor,
          labelStyle: ColiveStyles.title22w700,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.pt),
          indicator: ColiveAnchorTabIndicator(
            tabController: controller.tabController,
          ),
          tabs: [
            Tab(
              text: 'colive_popular'.tr,
              iconMargin: EdgeInsets.zero,
            ),
            Tab(
              text: 'colive_follow'.tr,
              iconMargin: EdgeInsets.zero,
            ),
          ],
        ),
        end: Obx(
          () => Visibility(
            visible: state.isPopularTabObs.value,
            child: GestureDetector(
              onTap: controller.onTapFilter,
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 8.pt, horizontal: 10.pt),
                margin: EdgeInsets.symmetric(horizontal: 15.pt),
                decoration: BoxDecoration(
                  color: ColiveColors.cardColor,
                  borderRadius: BorderRadius.circular(20.pt),
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        state.currentAreaObs.value,
                        style: ColiveStyles.body12w400.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColiveColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.pt),
                    Image.asset(Assets.imagesColiveHomeFilterIcon,
                        width: 14.pt),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: controller.tabController,
            children: const [
              ColiveKeepAliveWidget(child: ColiveAnchorPopularWidget()),
              ColiveKeepAliveWidget(child: ColiveAnchorFollowWidget()),
            ],
          ),
          _buildFloatingWidget(),
        ],
      ),
    );
  }

  Widget _buildFloatingWidget() {
    return Obx(() {
      return Visibility(
        visible: state.floatingSecondsObs.value > 0,
        child: PositionedDirectional(
          end: state.floatingEndObs.value,
          bottom: state.floatingBottomObs.value,
          width: 60.pt,
          height: 60.pt,
          child: GestureDetector(
            onTap: controller.onTapFloating,
            onPanUpdate: (details) {
              final offset = details.delta;
              state.floatingEndObs.value = max(
                  min(state.floatingEndObs.value - offset.dx,
                      ColiveScreenAdapt.screenWidth - 60.pt),
                  0);
              state.floatingBottomObs.value = max(
                  min(state.floatingBottomObs.value - offset.dy,
                      ColiveScreenAdapt.screenHeight - 60.pt),
                  0);
            },
            child: Stack(
              children: [
                Lottie.asset(Assets.animatesColiveHomeFloating),
                PositionedDirectional(
                  bottom: 2.pt,
                  start: 0,
                  end: 0,
                  child: Container(
                    height: 16.pt,
                    padding: EdgeInsets.symmetric(horizontal: 2.pt),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.pt),
                      color: ColiveColors.primaryColor,
                    ),
                    child: Center(
                      child: AutoSizeText(
                        ColiveFormatUtil.durationToTime(
                            state.floatingSecondsObs.value),
                        minFontSize: 4,
                        style: ColiveStyles.body10w400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
