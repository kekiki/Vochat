import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/home_mine/my_follows/widgets/colive_following_list_widget.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/static/colive_colors.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_my_follows_controller.dart';
import 'colive_my_follows_state.dart';
import 'widgets/colive_blacklist_widget.dart';
import 'widgets/colive_follower_list_widget.dart';

class ColiveMyFollowsPage extends GetView<ColiveMyFollowsController> {
  const ColiveMyFollowsPage({super.key});

  static const pages = [
    ColiveFollowingListWidget(),
    ColiveFollowerListWidget(),
    ColiveBlacklistWidget(),
  ];
  ColiveMyFollowsState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(center: _buildSegmentWidget()),
      body: PageView.builder(
        itemCount: ColiveMyFollowsType.itemCount.index,
        controller: controller.pageController,
        onPageChanged: (value) {
          state.currentTypeObs.value = ColiveMyFollowsType.values[value];
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
    );
  }

  Widget _buildSegmentWidget() {
    return Container(
      height: 40.pt,
      width: 280.pt,
      padding: EdgeInsets.all(5.pt),
      decoration: BoxDecoration(
        color: ColiveColors.cardColor,
        borderRadius: BorderRadius.circular(20.pt),
      ),
      child: Stack(
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: ColiveMyFollowsType.itemCount.index,
            effect: WormEffect(
              dotHeight: 30.pt,
              dotWidth: 90.pt,
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
                      ColiveMyFollowsType.following.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 90.pt,
                    height: 30.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 6.pt),
                    child: AutoSizeText(
                      'colive_follow'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyFollowsType.following
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyFollowsType.follower.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 90.pt,
                    height: 40.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 6.pt),
                    child: AutoSizeText(
                      'colive_fans'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyFollowsType.follower
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(
                      ColiveMyFollowsType.blacklist.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    width: 90.pt,
                    height: 30.pt,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 6.pt),
                    child: AutoSizeText(
                      'colive_blacklist'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title12w500.copyWith(
                        color: state.currentTypeObs.value ==
                                ColiveMyFollowsType.blacklist
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
