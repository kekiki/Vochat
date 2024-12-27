import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../services/static/colive_colors.dart';
import '../../services/widgets/colive_empty_widget.dart';
import '../../services/widgets/colive_refresh_footer.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_moment_hot_controller.dart';
import 'colive_moment_item_widget.dart';

class ColiveMomentHotWidget extends GetView<ColiveMomentHotController> {
  const ColiveMomentHotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      refreshOnStart: true,
      controller: controller.refreshController,
      header: ColiveRefreshHeader.classic(),
      footer: ColiveRefreshFooter.classic(),
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      childBuilder: (context, physics) {
        return CustomScrollView(
          physics: physics,
          slivers: [
            SliverToBoxAdapter(
              child: Obx(
                () => Visibility(
                  visible: controller.isNoData.value,
                  child: ColiveEmptyWidget(text: 'colive_no_data'.tr),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => Visibility(
                  visible: controller.isLoadFailed.value,
                  child: ColiveEmptyWidget(text: 'colive_no_network'.tr),
                ),
              ),
            ),
            Obx(() {
              final momentList = List.from(controller.momentList);
              return SliverList.separated(
                itemBuilder: (context, index) {
                  final moment = momentList[index];
                  return ColiveMomentItemWidget(
                    moment: moment,
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
                itemCount: momentList.length,
              );
            }),
            SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
          ],
        );
      },
    );
  }
}
