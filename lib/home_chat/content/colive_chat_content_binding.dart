import 'package:get/get.dart';

import 'colive_chat_content_controller.dart';

class ColiveChatContentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveChatContentController());
  }
}
