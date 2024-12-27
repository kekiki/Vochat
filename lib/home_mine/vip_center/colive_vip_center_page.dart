import 'package:auto_size_text/auto_size_text.dart';
import 'package:colive/common/widgets/colive_gradient_border.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:colive/services/widgets/colive_app_bar.dart';
import 'package:colive/services/widgets/colive_app_scaffold.dart';

import '../../common/widgets/colive_marquee_widget.dart';
import '../../services/static/colive_colors.dart';
import '../../services/topup/colive_topup_service.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_vip_center_controller.dart';
import 'colive_vip_center_state.dart';

class ColiveVipCenterPage extends GetView<ColiveVipCenterController> {
  const ColiveVipCenterPage({super.key});

  ColiveVipCenterState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_vip'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 30.pt,
            color: ColiveColors.cardColor,
            child: ColiveMarqueeWidget(
              child: Text(
                'colive_vip_notice'.tr,
                style: ColiveStyles.body12w400,
              ),
            ),
          ),
          Expanded(
            child: EasyRefresh.builder(
              controller: controller.refreshController,
              header: ColiveRefreshHeader.classic(),
              onRefresh: controller.onRefresh,
              childBuilder: (context, physics) {
                return SingleChildScrollView(
                  physics: physics,
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      SizedBox(height: 12.pt),
                      _buildVipPrivilegesWidget(),
                      SizedBox(height: 32.pt),
                      Obx(() {
                        return Visibility(
                          visible: state.productListObs.isNotEmpty,
                          replacement: SizedBox(height: 218.pt),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15.pt),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _productItemWidget(index);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10.pt);
                            },
                            itemCount: state.productListObs.length,
                          ),
                        );
                      }),
                      SizedBox(height: 88.pt),
                      Obx(() {
                        final title = state.profileObs.value.isVIP
                            ? 'Renew VIP'
                            : 'Become VIP';
                        final vipDate = ColiveFormatUtil.millisecondsToDate(
                            state.profileObs.value.vipDate * 1000);
                        final vipDateText = '(Expired date:$vipDate)';
                        return InkWell(
                          onTap: controller.onTapVIP,
                          child: Container(
                            width: 311.pt,
                            height: 56.pt,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.pt),
                              gradient: ColiveColors.mainGradient,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: ColiveStyles.title18w700.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Visibility(
                                  visible: state.profileObs.value.isVIP,
                                  child: Text(
                                    vipDateText,
                                    style: ColiveStyles.body12w400.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productItemWidget(int index) {
    return Obx(() {
      final product = state.productListObs[index];
      final isSelected = state.selectedProductIndexObs.value == index;
      return GestureDetector(
        onTap: () {
          state.selectedProductIndexObs.value = index;
        },
        child: Container(
          height: 66.pt,
          decoration: BoxDecoration(
            color: ColiveColors.cardColor,
            borderRadius: BorderRadius.circular(12.pt),
            border: ColiveGradientBorder(
              gradient: isSelected
                  ? ColiveColors.mainGradient
                  : ColiveColors.clearGradient,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.pt),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesColiveVip,
                      width: 30.pt,
                      height: 30.pt,
                    ),
                    SizedBox(width: 6.pt),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.num} Days',
                          style: ColiveStyles.title18w700,
                        ),
                        Visibility(
                          visible:
                              product.giveNum > 0 || product.extraItemCount > 0,
                          child: Row(
                            children: [
                              Text(
                                '+${product.giveNum}',
                                style: ColiveStyles.body10w400.copyWith(
                                  color: ColiveColors.secondTextColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.pt),
                                child: Image.asset(
                                  Assets.imagesColiveDiamond,
                                  width: 12.pt,
                                  height: 12.pt,
                                ),
                              ),
                              Text(
                                ' | ',
                                style: ColiveStyles.body10w400.copyWith(
                                  color: ColiveColors.grayTextColor,
                                ),
                              ),
                              Text(
                                '+${product.extraItemCount}',
                                style: ColiveStyles.body10w400.copyWith(
                                  color: ColiveColors.secondTextColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.pt),
                                child: Image.asset(
                                  Assets.imagesColiveVideoCard,
                                  width: 14.pt,
                                  height: 14.pt,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 100.pt,
                      height: 30.pt,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 6.pt),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.pt),
                        gradient: ColiveColors.mainGradient,
                      ),
                      child: AutoSizeText(
                        ColiveTopupService.instance.localPrice(product),
                        maxLines: 1,
                        minFontSize: 8,
                        style: ColiveStyles.title12w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildVipPrivilegesWidget() {
    return SizedBox(
      width: ColiveScreenAdapt.screenWidth,
      height: 120.pt,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: state.privilegeList.length,
            itemBuilder: (context, index, realIndex) {
              final item = state.privilegeList[index];
              return _buildPrivilegeItemWidget(item);
            },
            options: CarouselOptions(
              height: 100.pt,
              aspectRatio: 345 / 100,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                state.currentPrivilegeIndexObs.value = index;
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: state.privilegeList.map((e) {
              return Obx(() {
                final isSelect = state.currentPrivilegeIndexObs.value ==
                    state.privilegeList.indexOf(e);
                final double width;
                final Color color;
                if (isSelect) {
                  width = 20.pt;
                  color = ColiveColors.primaryColor;
                } else {
                  width = 6.pt;
                  color = rgba(0, 0, 0, 0.2);
                }
                return Container(
                  width: width,
                  height: 6.pt,
                  margin: EdgeInsets.symmetric(horizontal: 3.pt),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(22.pt),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivilegeItemWidget(ColiveVipPrivilegeModel item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.pt),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.pt),
        gradient: LinearGradient(colors: item.colors),
      ),
      child: Row(
        children: [
          Image.asset(item.icon, width: 66.pt, height: 66.pt),
          SizedBox(width: 12.pt),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  item.title,
                  maxLines: 1,
                  minFontSize: 8,
                  style: ColiveStyles.title14w600.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6.pt),
                Text(
                  item.desc,
                  style: ColiveStyles.body12w400.copyWith(
                    color: Colors.white.withOpacity(0.6),
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
