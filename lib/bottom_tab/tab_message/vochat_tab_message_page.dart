import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/vochat_app_bar.dart';
import '../../common/widgets/vochat_app_scaffold.dart';
import 'vochat_tab_message_controller.dart';
import 'vochat_tab_message_state.dart';

class VochatTabMessagePage extends GetView<VochatTabMessageController> {
  const VochatTabMessagePage({super.key});

  VochatTabMessageState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return VochatAppScaffold(
      appBar: const VochatAppBar(
        isAllowBack: false,
        center: Text('VochatTabMessagePage'),
      ),
      body: Container(),
    );
  }
}
