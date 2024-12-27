import 'package:get/get.dart';

import 'colive_vip_center_controller.dart';

class ColiveVipCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveVipCenterController());
  }
}
