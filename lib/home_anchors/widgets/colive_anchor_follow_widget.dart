import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_item_widget.dart';
import 'package:colive/services/widgets/colive_empty_widget.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/widgets/colive_refresh_footer.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_anchor_follow_controller.dart';

class ColiveAnchorFollowWidget
    extends GetView<ColiveAnchorFollowController> {
  const ColiveAnchorFollowWidget({super.key});

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
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.pt),
          child: CustomScrollView(
            physics: physics,
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
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
                final anchorList =
                    List<ColiveAnchorModel>.from(controller.anchorList);
                return SliverGrid.builder(
                  itemCount: anchorList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.pt,
                    crossAxisSpacing: 9.pt,
                    childAspectRatio: 168 / 200,
                  ),
                  itemBuilder: (context, index) {
                    final anchor = anchorList[index];
                    return ColiveAnchorItemWidget(
                      anchor: anchor,
                      onTapAnchor: controller.onTapAnchor,
                      onTapCall: controller.onTapCall,
                      onTapChat: controller.onTapChat,
                    );
                  },
                );
              }),
              SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
            ],
          ),
        );
      },
    );
  }
}
