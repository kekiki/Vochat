import 'package:get/get.dart';

import 'vochat_bottom_tab_controller.dart';

class VochatBottomTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatBottomTabController());
  }
}
