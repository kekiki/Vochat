import 'package:get/get.dart';

import 'colive_home_controller.dart';

class ColiveHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveHomeController());
  }
}
