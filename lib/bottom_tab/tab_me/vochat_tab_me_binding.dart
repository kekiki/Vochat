import 'package:get/get.dart';

import 'vochat_tab_me_controller.dart';

class VochatTabMeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatTabMeController());
  }
}
