import 'package:get/get.dart';

import 'vochat_tab_message_controller.dart';

class VochatTabMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatTabMessageController());
  }
}
