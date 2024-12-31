import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widgets/vochat_app_scaffold.dart';
import 'tab_community/vochat_tab_community_page.dart';
import 'tab_home/vochat_tab_home_page.dart';
import 'tab_me/vochat_tab_me_page.dart';
import 'tab_message/vochat_tab_message_page.dart';
import 'vochat_bottom_tab_controller.dart';
import 'vochat_bottom_tab_state.dart';
import 'vochat_bottom_tabbar.dart';

class VochatBottomTabPage extends GetView<VochatBottomTabController> {
  const VochatBottomTabPage({super.key});

  VochatBottomTabState get state => controller.state;

  static List<Widget> homePages = [
    const VochatTabHomePage(),
    const VochatTabCommunityPage(),
    const VochatTabMessagePage(),
    const VochatTabMePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return VochatAppScaffold(
      isAllowBack: false,
      safeTop: false,
      body: Obx(() {
        return IndexedStack(
          sizing: StackFit.expand,
          index: state.selectedTabTypeObs.value.index,
          children: homePages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return VochatBottomTabbar(
          selectedType: state.selectedTabTypeObs.value,
          messageCount: state.unReadMessageCountObs.value,
          onTapTab: controller.onTapTabItem,
        );
      }),
    );
  }
}
