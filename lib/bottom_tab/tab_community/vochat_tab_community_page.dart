import 'package:flutter/material.dart';

import '../../common/widgets/vochat_app_bar.dart';
import '../../common/widgets/vochat_app_scaffold.dart';
import '../../common/widgets/vochat_base_page.dart';
import 'vochat_tab_community_controller.dart';
import 'vochat_tab_community_state.dart';

class VochatTabCommunityPage
    extends VochatBasePage<VochatTabCommunityController> {
  const VochatTabCommunityPage({super.key});

  VochatTabCommunityState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return VochatAppScaffold(
      appBar: const VochatAppBar(
        isAllowBack: false,
        center: Text('VochatTabCommunityPage'),
      ),
      body: Container(),
    );
  }
}
