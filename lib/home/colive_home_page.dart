import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_moment/colive_home_moment_page.dart';
import '../services/widgets/colive_app_scaffold.dart';
import '../home_anchors/colive_home_anchors_page.dart';
import '../home_chat/colive_home_chat_page.dart';
import '../home_mine/colive_home_mine_page.dart';
import 'colive_home_controller.dart';
import 'widgets/colive_home_navigation_bar.dart';

class ColiveHomePage extends GetView<ColiveHomeController> {
  const ColiveHomePage({super.key});

  static const homePages = [
    ColiveHomeAnchorsPage(),
    ColiveHomeMomentPage(),
    ColiveHomeChatPage(),
    ColiveHomeMinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return ColiveAppScaffold(
      isAllowBack: false,
      safeTop: false,
      onBackPressed: controller.onBack,
      body: Obx(() {
        return IndexedStack(
          sizing: StackFit.expand,
          index: state.selectedTabTypeObs.value.index,
          children: homePages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return HomeNavigationBar(
          selectedType: state.selectedTabTypeObs.value,
          messageCount: state.unReadMessageCountObs.value,
          onTapTab: controller.onTapTabItem,
        );
      }),
    );
  }
}
