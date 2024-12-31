import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/widgets/vochat_round_image_widget.dart';

import '../../../common/adapts/vochat_colors.dart';
import '../../../common/adapts/vochat_styles.dart';
import '../../../common/generated/assets.dart';
import '../../../services/models/vochat_country_item_model.dart';
import '../../../services/models/vochat_product_base_model.dart';

class VochatTopupChannelHeader extends StatelessWidget {
  final VochatProductItemModel product;
  final VochatCountryItemModel country;
  final VoidCallback? onTapCountry;

  const VochatTopupChannelHeader({
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
                // Image.asset(
                //   Assets.imagesVochatVip,
                //   width: 40.pt,
                //   height: 40.pt,
                // ),
                // SizedBox(width: 14.pt),
                Text(
                  'vochat_%s_days'.trArgs(['${product.num}']),
                  style: VochatStyles.title18w700,
                ),
                SizedBox(width: 15.pt),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   Assets.imagesVochatDiamond,
                //   width: 40.pt,
                //   height: 40.pt,
                // ),
                // SizedBox(width: 14.pt),
                Text(
                  product.num.toString(),
                  style: VochatStyles.title18w700,
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
                  border: Border.all(color: VochatColors.primaryColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VochatRoundImageWidget(
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
                        style: VochatStyles.title14w600.copyWith(
                          color: VochatColors.primaryColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.pt),
                    Image.asset(
                      Assets.imagesVochatCountryArrowDown,
                      width: 14.pt,
                      height: 14.pt,
                      color: VochatColors.primaryColor,
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
