import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';
import 'package:vochat/common/generated/assets.dart';
import 'package:vochat/common/adapts/vochat_colors.dart';

import '../../../common/adapts/vochat_styles.dart';
import '../../../login/managers/vochat_profile_manager.dart';
import '../../../services/models/vochat_product_base_model.dart';
import '../../topup/vochat_topup_service.dart';

class VochatQuickRechargeDialog extends StatefulWidget {
  const VochatQuickRechargeDialog({
    super.key,
    required this.isBalanceInsufficient,
  });

  final bool isBalanceInsufficient;

  @override
  State<VochatQuickRechargeDialog> createState() =>
      _VochatQuickRechargeDialogState();
}

class _VochatQuickRechargeDialogState extends State<VochatQuickRechargeDialog> {
  int balance = 0;
  final List<StreamSubscription> subsriptions = [];
  final List<VochatProductItemModel> productList = [];

  @override
  void initState() {
    balance = VochatProfileManager.instance.userInfo.mizuan;
    _setupProductList();
    super.initState();

    subsriptions
        .add(VochatProfileManager.instance.profileStream.listen((event) {
      balance = event.mizuan;
      if (mounted) setState(() {});
    }));

    if (productList.isEmpty) {
      VochatLoadingUtil.show();
      VochatTopupService.instance.refreshAllProductList().then((value) {
        VochatLoadingUtil.dismiss();
        _setupProductList();
        if (mounted) setState(() {});
      }).catchError((err) {
        VochatLoadingUtil.dismiss();
        VochatLoadingUtil.showToast(err.toString());
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
    if (VochatTopupService.instance.promotionProductList.isNotEmpty) {
      productList.addAll(VochatTopupService.instance.promotionProductList);
    }
    if (productList.isNotEmpty) return;
    if (VochatTopupService.instance.productList.length > 3) {
      final list =
          VochatTopupService.instance.productList.getRange(0, 3).toList();
      productList.addAll(list);
    }
    if (productList.isNotEmpty) return;
    productList.addAll(VochatTopupService.instance.productList);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isBalanceInsufficient
        ? 'vochat_not_enough_diamods'.tr
        : 'vochat_quick_recharge'.tr;
    final balanceText = "${'vochat_my_balance'.tr}: $balance";
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
                    style: VochatStyles.title18w700,
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
                        style: VochatStyles.body14w400,
                      ),
                      SizedBox(width: 4.pt),
                      // Image.asset(
                      //   Assets.imagesVochatDiamond,
                      //   width: 16.pt,
                      //   height: 16.pt,
                      // ),
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
                        VochatTopupService.instance.purchase(product);
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
                  Assets.imagesVochatDialogTopEndClose,
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

  Widget _productItemWidget(VochatProductItemModel product) {
    if (product.isDiamondProduct) {
      return Container(
        height: 66.pt,
        decoration: BoxDecoration(
          color: VochatColors.cardColor,
          borderRadius: BorderRadius.circular(12.pt),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.pt),
              child: Row(
                children: [
                  // Image.asset(
                  //   Assets.imagesVochatDiamond,
                  //   width: 30.pt,
                  //   height: 30.pt,
                  // ),
                  SizedBox(width: 6.pt),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.num.toString(),
                        style: VochatStyles.title18w700,
                      ),
                      Visibility(
                        visible: product.giveVipDay > 0,
                        child: Text(
                          '+${product.giveVipDay * 24}H VIP',
                          style: VochatStyles.body10w400.copyWith(
                            color: VochatColors.secondTextColor,
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
                      color: VochatColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.pt),
                    ),
                    child: AutoSizeText(
                      VochatTopupService.instance.localPrice(product),
                      maxLines: 1,
                      minFontSize: 8,
                      style: VochatStyles.title12w700.copyWith(
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
                      'vochat_%s_off'.trArgs(['${product.discount}%']),
                      style: VochatStyles.body10w400.copyWith(
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
        color: VochatColors.cardColor,
        borderRadius: BorderRadius.circular(12.pt),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.pt),
            child: Row(
              children: [
                // Image.asset(
                //   Assets.imagesVochatVip,
                //   width: 30.pt,
                //   height: 30.pt,
                // ),
                SizedBox(width: 6.pt),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'vochat_%s_days'.trArgs(['${product.num}']),
                      style: VochatStyles.title18w700,
                    ),
                    Visibility(
                      visible:
                          product.giveNum > 0 || product.extraItemCount > 0,
                      child: Row(
                        children: [
                          Text(
                            '+${product.giveNum}',
                            style: VochatStyles.body10w400.copyWith(
                              color: VochatColors.secondTextColor,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 2.pt),
                          //   child: Image.asset(
                          //     Assets.imagesVochatDiamond,
                          //     width: 12.pt,
                          //     height: 12.pt,
                          //   ),
                          // ),
                          Text(
                            ' | ',
                            style: VochatStyles.body10w400.copyWith(
                              color: VochatColors.grayTextColor,
                            ),
                          ),
                          Text(
                            '+${product.extraItemCount}',
                            style: VochatStyles.body10w400.copyWith(
                              color: VochatColors.secondTextColor,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 2.pt),
                          //   child: Image.asset(
                          //     Assets.imagesVochatVideoCard,
                          //     width: 14.pt,
                          //     height: 14.pt,
                          //   ),
                          // ),
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
                    color: VochatColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.pt),
                  ),
                  child: AutoSizeText(
                    VochatTopupService.instance.localPrice(product),
                    maxLines: 1,
                    minFontSize: 8,
                    style: VochatStyles.title12w700.copyWith(
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
