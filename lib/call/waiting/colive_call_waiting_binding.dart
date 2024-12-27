import 'package:get/get.dart';

import 'colive_call_waiting_controller.dart';

class ColiveCallWaitingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveCallWaitingController());
  }
}
