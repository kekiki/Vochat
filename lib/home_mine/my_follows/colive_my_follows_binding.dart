import 'package:get/get.dart';

import 'colive_my_follows_controller.dart';

class ColiveMyFollowsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveMyFollowsController());
  }
}
