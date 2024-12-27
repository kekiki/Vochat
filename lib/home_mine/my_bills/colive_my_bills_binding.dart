import 'package:get/get.dart';

import 'colive_my_bills_controller.dart';

class ColiveMyBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveMyBillsController());
  }
}
