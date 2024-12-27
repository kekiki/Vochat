import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/topup/colive_topup_service.dart';

import '../../models/colive_product_base_model.dart';
import '../../static/colive_styles.dart';

class ColiveQuickRechargeDialog extends StatefulWidget {
  const ColiveQuickRechargeDialog({
    super.key,
    required this.isBalanceInsufficient,
  });

  final bool isBalanceInsufficient;

  @override
  State<ColiveQuickRechargeDialog> createState() =>
      _ColiveQuickRechargeDialogState();
}

class _ColiveQuickRechargeDialogState extends State<ColiveQuickRechargeDialog> {
  int balance = 0;
  final List<StreamSubscription> subsriptions = [];
  final List<ColiveProductItemModel> productList = [];

  @override
  void initState() {
    balance = ColiveProfileManager.instance.userInfo.diamonds;
    _setupProductList();
    super.initState();

    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      balance = event.diamonds;
      if (mounted) setState(() {});
    }));

    if (productList.isEmpty) {
      ColiveLoadingUtil.show();
      ColiveTopupService.instance.refreshAllProductList().then((value) {
        ColiveLoadingUtil.dismiss();
        _setupProductList();
        if (mounted) setState(() {});
      }).catchError((err) {
        ColiveLoadingUtil.dismiss();
        ColiveLoadingUtil.showToast(err.toString());
      });
    }
  }

  @override
  void dispose() {
    for (var element in subsriptions) {
      element.cancel();
    }
    subsriptions.clear();
    super.dispose();
  }

  void _setupProductList() {
    if (productList.isNotEmpty) return;
    if (ColiveTopupService.instance.promotionProductList.isNotEmpty) {
      productList.addAll(ColiveTopupService.instance.promotionProductList);
    }
    if (productList.isNotEmpty) return;
    if (ColiveTopupService.instance.productList.length > 3) {
      final list =
          ColiveTopupService.instance.productList.getRange(0, 3).toList();
      productList.addAll(list);
    }
    if (productList.isNotEmpty) return;
    productList.addAll(ColiveTopupService.instance.productList);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isBalanceInsufficient
        ? 'colive_not_enough_diamods'.tr
        : 'colive_quick_recharge'.tr;
    final balanceText = "${'colive_my_balance'.tr}: $balance";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.pt),
      constraints: BoxConstraints(minHeight: 360.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.pt),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: 20.pt,
              horizontal: 16.pt,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 34.pt,
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    minFontSize: 8,
                    style: ColiveStyles.title18w700,
                  ),
                ),
                SizedBox(height: 8.pt),
                SizedBox(
                  height: 18.pt,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        balanceText,
                        style: ColiveStyles.body14w400,
                      ),
                      SizedBox(width: 4.pt),
                      Image.asset(
                        Assets.imagesColiveDiamond,
                        width: 16.pt,
                        height: 16.pt,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.pt),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        ColiveTopupService.instance.purchase(product);
                      },
                      child: _productItemWidget(product),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.pt);
                  },
                  itemCount: productList.length,
                )
              ],
            ),
          ),
          PositionedDirectional(
            top: 0,
            end: 0,
            width: 52.pt,
            height: 52.pt,
            child: InkWell(
              onTap: Get.back,
              child: Center(
                child: Image.asset(
                  Assets.imagesColiveDialogTopEndClose,
                  width: 20.pt,
                  height: 20.pt,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productItemWidget(ColiveProductItemModel product) {
    if (product.isDiamondProduct) {
      return Container(
        height: 66.pt,
        decoration: BoxDecoration(
          color: ColiveColors.cardColor,
          borderRadius: BorderRadius.circular(12.pt),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.pt),
              child: Row(
                children: [
                  Image.asset(
                    Assets.imagesColiveDiamond,
                    width: 30.pt,
                    height: 30.pt,
                  ),
                  SizedBox(width: 6.pt),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.num.toString(),
                        style: ColiveStyles.title18w700,
                      ),
                      Visibility(
                        visible: product.giveVipDay > 0,
                        child: Text(
                          '+${product.giveVipDay * 24}H VIP',
                          style: ColiveStyles.body10w400.copyWith(
                            color: ColiveColors.secondTextColor,
                          ),
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
                      color: ColiveColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.pt),
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
            PositionedDirectional(
              top: 6.pt,
              end: 6.pt,
              child: Visibility(
                visible: product.discount > 0,
                child: Container(
                  height: 20.pt,
                  padding: EdgeInsets.symmetric(horizontal: 8.pt),
                  decoration: BoxDecoration(
                    color: rgba(128, 78, 237, 1),
                    borderRadius: BorderRadius.circular(10.pt),
                  ),
                  child: Center(
                    child: Text(
                      'colive_%s_off'.trArgs(['${product.discount}%']),
                      style: ColiveStyles.body10w400.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      height: 66.pt,
      decoration: BoxDecoration(
        color: ColiveColors.cardColor,
        borderRadius: BorderRadius.circular(12.pt),
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
                      'colive_%s_days'.trArgs(['${product.num}']),
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
                    color: ColiveColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.pt),
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
    );
  }
}
