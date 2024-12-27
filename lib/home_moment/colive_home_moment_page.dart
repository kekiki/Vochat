import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_keep_alive_widget.dart';

import '../generated/assets.dart';
import '../home_anchors/widgets/colive_anchor_tab_indicator.dart';
import '../services/static/colive_colors.dart';
import '../services/static/colive_styles.dart';
import '../services/widgets/colive_app_bar.dart';
import '../services/widgets/colive_app_scaffold.dart';
import 'colive_home_moment_controller.dart';
import 'colive_home_moment_state.dart';
import 'widgets/colive_moment_hot_widget.dart';
import 'widgets/colive_moment_mine_widget.dart';

class ColiveHomeMomentPage extends GetView<ColiveHomeMomentController> {
  const ColiveHomeMomentPage({super.key});

  ColiveHomeMomentState get state => controller.state;

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
          unselectedLabelColor:
              ColiveColors.primaryTextColor.withOpacity(0.6),
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
              text: 'colive_hot'.tr,
              iconMargin: EdgeInsets.zero,
            ),
            Tab(
              text: 'colive_mine'.tr,
              iconMargin: EdgeInsets.zero,
            ),
          ],
        ),
        end: Obx(
          () => Visibility(
            visible: state.isMineTabObs.value,
            child: IconButton(
              iconSize: 44.pt,
              padding: EdgeInsets.zero,
              onPressed: controller.onTapPost,
              icon: Image.asset(
                Assets.imagesColiveAppbarPost,
                width: 28.pt,
                height: 28.pt,
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          ColiveKeepAliveWidget(child: ColiveMomentHotWidget()),
          ColiveKeepAliveWidget(child: ColiveMomentMineWidget()),
        ],
      ),
    );
  }
}
