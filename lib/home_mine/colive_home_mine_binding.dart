import 'package:get/get.dart';

import 'colive_home_mine_controller.dart';

class ColiveHomeMineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveHomeMineController());
  }
}
