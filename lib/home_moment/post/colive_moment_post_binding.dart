import 'package:get/get.dart';

import 'colive_moment_post_controller.dart';

class ColiveMomentPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveMomentPostController());
  }
}
