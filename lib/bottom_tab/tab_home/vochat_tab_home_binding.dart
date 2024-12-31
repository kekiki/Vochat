import 'package:get/get.dart';

import 'vochat_tab_home_controller.dart';

class VochatTabHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatTabHomeController());
  }
}
