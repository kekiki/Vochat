import 'package:get/get.dart';

import 'colive_home_chat_controller.dart';

class ColiveHomeChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveHomeChatController());
  }
}
