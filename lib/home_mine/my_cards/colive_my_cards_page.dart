import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../services/models/colive_card_base_model.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import '../../services/widgets/colive_empty_widget.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_my_cards_controller.dart';
import 'colive_my_cards_state.dart';

class ColiveMyCardsPage extends GetView<ColiveMyCardsController> {
  const ColiveMyCardsPage({super.key});

  ColiveMyCardsState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_cards'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        refreshOnStart: state.dataListObs.isEmpty,
        header: ColiveRefreshHeader.classic(),
        onRefresh: controller.onRefresh,
        childBuilder: (context, physics) {
          return Obx(() {
            return CustomScrollView(
              physics: physics,
              slivers: [
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: state.isNoDataObs.value,
                    child: ColiveEmptyWidget(text: 'colive_no_data'.tr),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: state.isLoadFailedObs.value,
                    child: ColiveEmptyWidget(text: 'colive_no_network'.tr),
                  ),
                ),
                SliverList.builder(
                  itemCount: state.dataListObs.length,
                  itemBuilder: (context, index) {
                    final anchor = state.dataListObs[index];
                    return _listItemWidget(anchor);
                  },
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _listItemWidget(ColiveCardItemModel item) {
    return Container(
      height: 90.pt,
      margin: EdgeInsets.symmetric(horizontal: 15.pt, vertical: 6.pt),
      padding: EdgeInsets.symmetric(horizontal: 15.pt),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.pt),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: rgba(194, 198, 213, 0.5),
            offset: Offset(0, 2.pt),
            blurRadius: 5.pt,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.pt,
            height: 60.pt,
            decoration: BoxDecoration(
              color: ColiveColors.cardColor,
              borderRadius: BorderRadius.circular(8.pt),
            ),
            child: Center(
              child: ColiveRoundImageWidget(item.icon,
                  width: 44.pt, height: 44.pt),
            ),
          ),
          SizedBox(width: 10.pt),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  item.name,
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                  style: ColiveStyles.title16w700,
                ),
                SizedBox(height: 8.pt),
                AutoSizeText(
                  item.desc,
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.pt),
          Text(
            'x${item.num}',
            style: ColiveStyles.body14w400.copyWith(
              color: ColiveColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
