import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/topup/colive_topup_service.dart';

import '../../../common/utils/colive_format_util.dart';
import '../../models/colive_product_base_model.dart';
import '../../static/colive_styles.dart';

class ColiveFirstRechargeDialog extends StatefulWidget {
  const ColiveFirstRechargeDialog({super.key, required this.product});

  final ColiveProductItemModel product;

  @override
  State<ColiveFirstRechargeDialog> createState() =>
      _ColiveFirstRechargeDialogState();
}

class _ColiveFirstRechargeDialogState
    extends State<ColiveFirstRechargeDialog> {
  int countdown = 0;

  @override
  void initState() {
    super.initState();

    ColiveTopupService.instance
        .addPromotionCountdownAction(_firstRechargeCountdown);
  }

  @override
  void dispose() {
    ColiveTopupService.instance
        .removePromotionCountdownAction(_firstRechargeCountdown);
    super.dispose();
  }

  void _firstRechargeCountdown(int seconds) {
    countdown = seconds;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 34.pt),
            Container(
              width: 282.pt,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.pt),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 56.pt),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.pt),
                    child: AutoSizeText(
                      'colive_limited_time_offer'.tr,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title18w700,
                    ),
                  ),
                  SizedBox(height: 20.pt),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imagesColiveDiamond, width: 46.pt),
                      SizedBox(width: 12.pt),
                      Text(
                        widget.product.num.toString(),
                        style: ColiveStyles.title22w700.copyWith(
                          fontSize: 36.pt,
                          color: rgba(255, 62, 93, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.pt),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      ColiveTopupService.instance.purchase(widget.product);
                    },
                    child: Container(
                      width: 230.pt,
                      height: 50.pt,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16.pt),
                      decoration: BoxDecoration(
                        color: rgba(255, 62, 93, 1),
                        borderRadius: BorderRadius.circular(25.pt),
                      ),
                      child: AutoSizeText(
                        ColiveTopupService.instance
                            .localPrice(widget.product),
                        maxLines: 1,
                        minFontSize: 8,
                        style: ColiveStyles.title22w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.pt),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imagesColiveIconsClock,
                        width: 16.pt,
                        color: rgba(255, 62, 93, 1),
                      ),
                      SizedBox(width: 6.pt),
                      Text(
                        ColiveFormatUtil.durationToTime(countdown),
                        style: ColiveStyles.body14w400.copyWith(
                          color: rgba(255, 62, 93, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.pt),
                ],
              ),
            ),
            SizedBox(height: 40.pt),
            InkWell(
              onTap: Get.back,
              child: Image.asset(
                Assets.imagesColiveDialogClose,
                width: 28.pt,
                height: 28.pt,
              ),
            ),
          ],
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          child: Center(
            child: Container(
              width: 207.pt,
              height: 74.pt,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesColiveLimitedTimeOfferOffBg),
                ),
              ),
              child: AutoSizeText(
                'colive_%s_off'.trArgs(['${widget.product.discount}%']),
                maxLines: 1,
                minFontSize: 8,
                style: ColiveStyles.title26w600.copyWith(
                  color: Colors.white,
                ),
              ).marginOnly(top: 10.pt),
            ),
          ),
        ),
      ],
    );
  }
}
