import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_item_widget.dart';
import 'package:colive/search/colive_search_state.dart';
import 'package:colive/search/widgets/colive_search_bar.dart';
import 'package:colive/search/widgets/colive_search_history_widget.dart';

import '../services/widgets/colive_app_scaffold.dart';
import '../services/widgets/colive_empty_widget.dart';
import 'colive_search_controller.dart';

class ColiveSearchPage extends GetView<ColiveSearchController> {
  const ColiveSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return ColiveAppScaffold(
      appBar: ColiveSearchBar(
        editingController: controller.editingController,
        onSearch: controller.onTapSearch,
      ),
      safeBottom: false,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Obx(
              () => Visibility(
                visible: state.statusObs.value == ColiveSearchStatus.init,
                child: ColiveSearchHistoryWidget(
                  historyList: List.from(state.historyListObs),
                  onTapSearch: controller.onTapSearch,
                  onTapClear: controller.onTapHistoryClear,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Visibility(
                visible: state.statusObs.value == ColiveSearchStatus.empty,
                child: ColiveEmptyWidget(text: 'colive_no_data'.tr),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Visibility(
                visible: state.statusObs.value == ColiveSearchStatus.failed,
                child: ColiveEmptyWidget(text: 'colive_no_network'.tr),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 15.pt),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Visibility(
                visible: state.statusObs.value == ColiveSearchStatus.list,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.pt),
                  itemCount: state.anchorListObs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.pt,
                    crossAxisSpacing: 9.pt,
                    childAspectRatio: 168 / 200,
                  ),
                  itemBuilder: (context, index) {
                    final anchor = state.anchorListObs[index];
                    return ColiveAnchorItemWidget(
                      anchor: anchor,
                      onTapAnchor: controller.onTapAnchor,
                      onTapCall: controller.onTapCall,
                      onTapChat: controller.onTapChat,
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 25.pt),
          ),
        ],
      ),
    );
  }
}
