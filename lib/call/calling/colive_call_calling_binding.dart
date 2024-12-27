import 'package:get/get.dart';

import 'colive_call_calling_controller.dart';

class ColiveCallCallingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveCallCallingController());
  }
}
