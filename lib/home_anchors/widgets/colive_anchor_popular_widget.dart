import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_item_widget.dart';
import 'package:colive/home_anchors/widgets/colive_banner_widget.dart';

import '../../generated/assets.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_banner_model.dart';
import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_empty_widget.dart';
import '../../services/widgets/colive_refresh_footer.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_anchor_popular_controller.dart';

class ColiveAnchorPopularWidget extends GetView<ColiveAnchorPopularController> {
  const ColiveAnchorPopularWidget({super.key});

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
              child: GestureDetector(
                onTap: controller.onTapSearch,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.pt, vertical: 15.pt),
                  padding: EdgeInsets.symmetric(horizontal: 10.pt),
                  height: 38.pt,
                  decoration: BoxDecoration(
                    color: ColiveColors.cardColor,
                    borderRadius: BorderRadius.circular(19.pt),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imagesColiveSearchBarIcon,
                        width: 16.pt,
                        height: 16.pt,
                      ),
                      SizedBox(width: 8.pt),
                      Text(
                        'colive_search_placeholder'.tr,
                        style: ColiveStyles.body12w400.copyWith(
                          color: rgba(147, 148, 163, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Obx(() {
              final bannerList =
                  List<ColiveBannerModel>.from(controller.bannerList);
              return Visibility(
                visible: bannerList.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15.pt),
                  child: ColiveBannerWidget(
                    width: ColiveScreenAdapt.screenWidth,
                    height: 90.pt,
                    bannerList: bannerList,
                    onTapBanner: controller.onTapBanner,
                  ),
                ),
              );
            })),
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.pt),
              sliver: Obx(() {
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
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
          ],
        );
      },
    );
  }
}
