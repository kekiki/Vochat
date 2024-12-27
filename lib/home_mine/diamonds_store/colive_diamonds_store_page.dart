import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_gradient_border.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:colive/services/topup/colive_topup_service.dart';
import 'package:colive/services/widgets/colive_app_bar.dart';
import 'package:colive/services/widgets/colive_app_scaffold.dart';

import '../../common/utils/colive_format_util.dart';
import '../../services/models/colive_product_base_model.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_diamonds_store_controller.dart';
import 'colive_diamonds_store_state.dart';

class ColiveDiamondsStorePage extends GetView<ColiveDiamondsStoreController> {
  const ColiveDiamondsStorePage({super.key});

  ColiveDiamondsStoreState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_store'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.pt),
        child: EasyRefresh.builder(
          controller: controller.refreshController,
          header: ColiveRefreshHeader.classic(),
          refreshOnStart: state.productListObs.isEmpty,
          onRefresh: controller.onRefresh,
          childBuilder: (context, physics) {
            return Obx(() {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 6.pt)),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          "${'colive_my_balance'.tr}:",
                          style: ColiveStyles.body16w400,
                        ),
                        const Spacer(),
                        Image.asset(Assets.imagesColiveDiamond, width: 16.pt),
                        SizedBox(width: 6.pt),
                        Text(
                          "${state.profileObs.value.diamonds}",
                          style: ColiveStyles.title16w700,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.pt)),
                  SliverToBoxAdapter(child: _firstRechargeProductWidget()),
                  SliverGrid.builder(
                    itemCount: state.productListObs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 166 / 186,
                      mainAxisSpacing: 12.pt,
                      crossAxisSpacing: 11.pt,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.productListObs[index];
                      return _productItemWidget(product);
                    },
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.pt)),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Widget _firstRechargeProductWidget() {
    return Obx(() {
      if (state.firstRechargeProduct.value == null) {
        return const SizedBox.shrink();
      }
      final product = state.firstRechargeProduct.value!;
      return GestureDetector(
        onTap: () => controller.onTapProduct(product),
        child: Container(
          height: 90.pt,
          padding: EdgeInsets.symmetric(horizontal: 15.pt),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(16.pt),
            gradient: ColiveColors.mainGradient,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.imagesColiveDiamond,
                    width: 40.pt,
                    height: 40.pt,
                  ),
                  SizedBox(width: 14.pt),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.num.toString(),
                        style: ColiveStyles.title22w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 24.pt,
                        padding: EdgeInsets.symmetric(horizontal: 15.pt),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.pt),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            'colive_%s_off'.trArgs(['${product.discount}%']),
                            style: ColiveStyles.body12w400.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 134.pt,
                    height: 40.pt,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 6.pt),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.pt),
                    ),
                    child: AutoSizeText(
                      ColiveTopupService.instance.localPrice(product),
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title16w600.copyWith(
                        color: ColiveColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Visibility(
                  visible: state.countdownObs.value > 0,
                  replacement: SizedBox(height: 24.pt),
                  child: Center(
                    child: Container(
                      height: 20.pt,
                      padding: EdgeInsets.symmetric(horizontal: 8.pt),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12.pt),
                        ),
                        border: ColiveGradientBorder(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColiveColors.primaryColor.withOpacity(0),
                              ColiveColors.primaryColor,
                            ],
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.imagesColiveIconsClock,
                            width: 12.pt,
                            color: rgba(255, 62, 93, 1),
                          ),
                          SizedBox(width: 2.pt),
                          Obx(
                            () => Text(
                              ColiveFormatUtil.durationToTime(
                                  state.countdownObs.value),
                              style: ColiveStyles.body10w400.copyWith(
                                color: rgba(255, 62, 93, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).marginOnly(bottom: 12.pt),
      );
    });
  }

  Widget _productItemWidget(ColiveProductItemModel product) {
    return GestureDetector(
      onTap: () => controller.onTapProduct(product),
      child: Container(
        decoration: BoxDecoration(
          color: ColiveColors.cardColor,
          borderRadius: BorderRadius.circular(24.pt),
        ),
        child: Column(
          children: [
            Visibility(
              visible: product.discount > 0,
              replacement: SizedBox(height: 24.pt),
              child: Container(
                height: 24.pt,
                width: 72.pt,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 6.pt),
                decoration: BoxDecoration(
                  color: ColiveColors.cardColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.pt),
                  ),
                  border: ColiveGradientBorder(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColiveColors.primaryColor.withOpacity(0),
                        ColiveColors.primaryColor,
                      ],
                    ),
                  ),
                ),
                child: AutoSizeText(
                  'colive_%s_off'.trArgs(['${product.discount}%']),
                  maxLines: 1,
                  minFontSize: 8,
                  style: ColiveStyles.body12w400.copyWith(
                    color: ColiveColors.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 26.pt),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.num.toString(),
                  style: ColiveStyles.title22w700,
                ),
                SizedBox(width: 6.pt),
                Image.asset(
                  Assets.imagesColiveDiamond,
                  width: 27.pt,
                  height: 27.pt,
                ),
              ],
            ),
            SizedBox(height: 11.pt),
            Visibility(
              visible: product.giveVipDay > 0,
              child: Text(
                '+${product.giveVipDay * 24}H VIP',
                style: ColiveStyles.body12w400,
              ),
            ),
            const Spacer(),
            Container(
              width: 134.pt,
              height: 40.pt,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 6.pt),
              decoration: BoxDecoration(
                color: ColiveColors.primaryColor,
                borderRadius: BorderRadius.circular(20.pt),
              ),
              child: AutoSizeText(
                ColiveTopupService.instance.localPrice(product),
                maxLines: 1,
                minFontSize: 8,
                style: ColiveStyles.title16w600.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.pt),
          ],
        ),
      ),
    );
  }
}
