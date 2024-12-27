import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../services/widgets/dialogs/gift/colive_gift_icon_widget.dart';
import '../../../services/models/colive_gift_base_model.dart';

class ColiveChatInputGiftWidget extends StatelessWidget {
  const ColiveChatInputGiftWidget({
    super.key,
    required this.giftModel,
    required this.onTapSendGift,
    required this.balance,
    required this.onTapTopup,
  });

  final ColiveGiftBaseModel giftModel;
  final ValueChanged<ColiveGiftItemModel> onTapSendGift;

  final int balance;
  final VoidCallback onTapTopup;

  List<ColiveGiftItemModel> get _giftList => giftModel.giftList;

  @override
  Widget build(BuildContext context) {
    final selectedIndexObs = (-1).obs;
    return Container(
      height: 280.pt,
      margin: EdgeInsets.symmetric(vertical: 8.pt, horizontal: 12.pt),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: _giftList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 88 / 100,
              ),
              itemBuilder: (context, index) {
                return Obx(() {
                  final item = _giftList[index];
                  final isSelected = index == selectedIndexObs.value;
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        onTapSendGift(item);
                      } else {
                        selectedIndexObs.value = index;
                      }
                    },
                    child: _giftItemWidget(item, isSelected),
                  );
                });
              },
            ),
          ),
          SizedBox(
            height: 44.pt,
            child: Row(
              children: [
                Image.asset(Assets.imagesColiveDiamond,
                    width: 18.pt, height: 18.pt),
                SizedBox(width: 4.pt),
                Text(balance.toString(), style: ColiveStyles.body14w600),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTapTopup,
                  child: Container(
                    height: 30.pt,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15.pt),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.pt),
                      border: Border.all(color: ColiveColors.primaryColor),
                    ),
                    child: Text(
                      'colive_topup'.tr,
                      style: ColiveStyles.body14w600.copyWith(
                        color: ColiveColors.primaryColor,
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

  Widget _giftItemWidget(ColiveGiftItemModel item, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.pt),
        border: Border.all(
          color: isSelected ? ColiveColors.primaryColor : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.pt),
          ColiveGiftIconWidget(item.id.toString(), item.logo),
          SizedBox(height: 8.pt),
          Visibility(
            visible: isSelected,
            replacement: AutoSizeText(
              item.backName,
              maxLines: 1,
              minFontSize: 8,
              style: ColiveStyles.body12w400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesColiveDiamond,
                  width: 13.pt,
                  height: 13.pt,
                ),
                SizedBox(width: 3.pt),
                Text(item.price.toString(), style: ColiveStyles.body10w400),
              ],
            ),
          ),
          SizedBox(height: 6.pt),
          Expanded(
            child: Visibility(
              visible: isSelected,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.imagesColiveDiamond,
                    width: 13.pt,
                    height: 13.pt,
                  ),
                  SizedBox(width: 3.pt),
                  Text(item.price.toString(), style: ColiveStyles.body10w400),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColiveColors.primaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8.pt))),
                child: Text(
                  'colive_send'.tr,
                  style: ColiveStyles.body12w400.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
