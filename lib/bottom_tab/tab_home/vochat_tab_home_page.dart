import 'package:flutter/material.dart';

import '../../common/widgets/vochat_app_bar.dart';
import '../../common/widgets/vochat_app_scaffold.dart';
import '../../common/widgets/vochat_base_page.dart';
import 'vochat_tab_home_controller.dart';
import 'vochat_tab_home_state.dart';

class VochatTabHomePage extends VochatBasePage<VochatTabHomeController> {
  const VochatTabHomePage({super.key});

  VochatTabHomeState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return VochatAppScaffold(
      appBar: const VochatAppBar(
        isAllowBack: false,
        center: Text('VochatTabHomePage'),
      ),
      body: Container(),
    );
  }
}
