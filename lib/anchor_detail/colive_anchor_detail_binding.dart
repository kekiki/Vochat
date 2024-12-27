import 'package:get/get.dart';

import 'colive_anchor_detail_controller.dart';

class ColiveAnchorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveAnchorDetailController());
  }
}
