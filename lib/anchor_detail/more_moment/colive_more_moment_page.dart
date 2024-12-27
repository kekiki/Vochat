import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import '../../services/widgets/colive_refresh_footer.dart';
import '../../services/widgets/colive_refresh_header.dart';
import '../widgets/colive_anchor_moment_widget.dart';
import 'colive_more_moment_controller.dart';

class ColiveMoreMomentPage extends GetView<ColiveMoreMomentController> {
  const ColiveMoreMomentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveMoreMomentController());
    return ColiveAppScaffold(
      safeBottom: false,
      appBar: ColiveAppBar(
        center: Text(
          "colive_moment".tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        header: ColiveRefreshHeader.classic(),
        footer: ColiveRefreshFooter.classic(),
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (context, physics) {
          return Obx(() {
            return ListView.separated(
              physics: physics,
              itemBuilder: (context, index) {
                final moment = controller.momentListObs[index];
                return Padding(
                  padding: EdgeInsets.only(top: 15.pt),
                  child: ColiveAnchorMomentidget(moment: moment),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0.5,
                  indent: 15.pt,
                  endIndent: 15.pt,
                  color: ColiveColors.separatorLineColor,
                );
              },
              itemCount: controller.momentListObs.length,
            );
          });
        },
      ),
    );
  }
}
