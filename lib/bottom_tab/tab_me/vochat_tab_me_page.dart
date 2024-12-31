import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/vochat_app_bar.dart';
import '../../common/widgets/vochat_app_scaffold.dart';
import 'vochat_tab_me_controller.dart';
import 'vochat_tab_me_state.dart';

class VochatTabMePage extends GetView<VochatTabMeController> {
  const VochatTabMePage({super.key});

  VochatTabMeState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return VochatAppScaffold(
      appBar: const VochatAppBar(
        isAllowBack: false,
        center: Text('VochatTabMePage'),
      ),
      body: Container(),
    );
  }
}
