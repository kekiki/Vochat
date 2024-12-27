import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../models/colive_country_item_model.dart';
import '../../models/colive_product_base_model.dart';
import '../../static/colive_styles.dart';

class ColiveTopupChannelHeader extends StatelessWidget {
  final ColiveProductItemModel product;
  final ColiveCountryItemModel country;
  final VoidCallback? onTapCountry;

  const ColiveTopupChannelHeader({
    super.key,
    required this.product,
    required this.country,
    this.onTapCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.pt),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: product.isDiamondProduct,
            replacement: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.imagesColiveVip,
                  width: 40.pt,
                  height: 40.pt,
                ),
                SizedBox(width: 14.pt),
                Text(
                  'colive_%s_days'.trArgs(['${product.num}']),
                  style: ColiveStyles.title18w700,
                ),
                SizedBox(width: 15.pt),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.imagesColiveDiamond,
                  width: 40.pt,
                  height: 40.pt,
                ),
                SizedBox(width: 14.pt),
                Text(
                  product.num.toString(),
                  style: ColiveStyles.title18w700,
                ),
                SizedBox(width: 15.pt),
              ],
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: onTapCountry,
              child: Container(
                height: 32.pt,
                padding: EdgeInsets.symmetric(horizontal: 12.pt),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.pt),
                  border: Border.all(color: ColiveColors.primaryColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColiveRoundImageWidget(
                      country.logo,
                      width: 20.pt,
                      height: 20.pt,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 4.pt),
                    Flexible(
                      child: Text(
                        country.showName,
                        maxLines: 1,
                        style: ColiveStyles.title14w600.copyWith(
                          color: ColiveColors.primaryColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.pt),
                    Image.asset(
                      Assets.imagesColiveCountryArrowDown,
                      width: 14.pt,
                      height: 14.pt,
                      color: ColiveColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
