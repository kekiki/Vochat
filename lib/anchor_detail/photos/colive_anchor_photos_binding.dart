import 'package:get/get.dart';

import 'colive_anchor_photos_controller.dart';

class ColiveAnchorPhotosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveAnchorPhotosController());
  }
}
