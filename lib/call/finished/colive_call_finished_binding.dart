import 'package:get/get.dart';

import 'colive_call_finished_controller.dart';

class ColiveCallFinishedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveCallFinishedController());
  }
}
