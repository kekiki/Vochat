import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../services/widgets/colive_app_bar.dart';
import '../services/widgets/colive_app_scaffold.dart';
import '../services/static/colive_styles.dart';
import '../services/widgets/colive_refresh_header.dart';
import 'colive_home_mine_controller.dart';
import 'colive_home_mine_state.dart';
import 'my_follows/colive_my_follows_state.dart';

class ColiveHomeMinePage extends GetView<ColiveHomeMineController> {
  const ColiveHomeMinePage({super.key});

  ColiveHomeMineState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        isAllowBack: false,
        startSpacing: 15.pt,
        start: Text(
          "colive_mine".tr,
          style: ColiveStyles.title22w700,
        ),
        end: InkWell(
          onTap: controller.onTapCustomService,
          child: Container(
            width: 44.pt,
            height: 44.pt,
            alignment: Alignment.center,
            child: Image.asset(
              Assets.imagesColiveMineCustomerService,
              width: 24.pt,
              height: 24.pt,
            ),
          ),
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        header: ColiveRefreshHeader.classic(),
        onRefresh: controller.onRefresh,
        childBuilder: (context, physics) {
          return Obx(() {
            return CustomScrollView(
              physics: physics,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(15.pt),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: controller.onTapEditProfile,
                          child: ColiveRoundImageWidget(
                            state.profileObs.value.avatar,
                            width: 60.pt,
                            height: 60.pt,
                            isCircle: true,
                            placeholder: Assets.imagesColiveAvatarUser,
                          ),
                        ),
                        SizedBox(width: 14.pt),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.profileObs.value.nickname,
                              style: ColiveStyles.title16w700,
                            ),
                            SizedBox(height: 4.pt),
                            Text(
                              'colive_id_num_%s'.trArgs(
                                  [state.profileObs.value.id.toString()]),
                              style: ColiveStyles.body12w400.copyWith(
                                color: ColiveColors.grayTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: controller.onTapEditProfile,
                          child: Image.asset(
                            Assets.imagesColiveMineEdit,
                            width: 25.pt,
                            height: 25.pt,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 32.pt),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _followItemWidget(
                          text: 'colive_follow'.tr,
                          value: state.profileObs.value.follow,
                          followsType: ColiveMyFollowsType.following,
                        ),
                        _followItemWidget(
                          text: 'colive_fans'.tr,
                          value: state.profileObs.value.fans,
                          followsType: ColiveMyFollowsType.follower,
                        ),
                        _followItemWidget(
                          text: 'colive_blacklist'.tr,
                          value: state.profileObs.value.block,
                          followsType: ColiveMyFollowsType.blacklist,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: controller.onTapStore,
                    child: Container(
                      height: 80.pt,
                      margin:
                          EdgeInsetsDirectional.symmetric(horizontal: 15.pt),
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 15.pt),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(16.pt),
                        gradient: ColiveColors.mainGradient,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.imagesColiveDiamond,
                            width: 50.pt,
                            height: 50.pt,
                          ),
                          SizedBox(width: 14.pt),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'colive_store'.tr,
                                style: ColiveStyles.title16w700.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6.pt),
                              Text(
                                "${'colive_my_balance'.tr}: ${state.profileObs.value.diamonds}",
                                style: ColiveStyles.body12w400.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            Assets.imagesColiveMineArrowRight,
                            color: Colors.white,
                            width: 17.pt,
                            height: 17.pt,
                          ).rtl,
                        ],
                      ),
                    ).marginOnly(top: 16.pt),
                  ),
                ),
                SliverList.separated(
                  itemCount: state.dataListObs.length,
                  itemBuilder: (context, index) {
                    final item = state.dataListObs[index];
                    return _settingItemWidget(item);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0.5,
                      indent: 45.pt,
                      color: ColiveColors.separatorLineColor,
                    );
                  },
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _followItemWidget({
    required String text,
    required int value,
    required ColiveMyFollowsType followsType,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.onTapFollows(followsType),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: ColiveStyles.body20w400,
          ),
          Text(
            text,
            style: ColiveStyles.body12w400.copyWith(
              color: ColiveColors.grayTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingItemWidget(ColiveMineListItem item) {
    final isNoDisturb = item.title == 'colive_no_disturb';
    return InkWell(
      onTap: isNoDisturb ? null : item.onTap,
      child: Container(
        height: 60.pt,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15.pt),
        child: Row(
          children: [
            Image.asset(
              item.icon,
              width: 20.pt,
              height: 20.pt,
              color: rgba(102, 102, 102, 1),
            ),
            SizedBox(width: 14.pt),
            Text(
              item.title.tr,
              style: ColiveStyles.body14w400.copyWith(
                color: ColiveColors.secondTextColor,
              ),
            ),
            const Spacer(),
            Text(
              item.subTitle ?? '',
              style: ColiveStyles.body12w400.copyWith(
                color: ColiveColors.primaryColor,
              ),
            ),
            SizedBox(width: 4.pt),
            Visibility(
              visible: !isNoDisturb,
              replacement: Obx(
                () => Switch(
                  value: state.isNoDisturbModeObs.value,
                  activeTrackColor: ColiveColors.primaryColor,
                  inactiveThumbColor:
                      ColiveColors.primaryTextColor.withOpacity(0.8),
                  inactiveTrackColor:
                      ColiveColors.primaryTextColor.withOpacity(0.2),
                  trackOutlineWidth: WidgetStateProperty.all(0),
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.transparent),
                  onChanged: (_) => item.onTap!(),
                ),
              ),
              child: Image.asset(
                Assets.imagesColiveMineArrowRight,
                width: 17.pt,
                height: 17.pt,
              ).rtl,
            ),
          ],
        ),
      ),
    );
  }
}
