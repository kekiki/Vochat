import 'package:get/get.dart';

import 'colive_anchor_videos_controller.dart';

class ColiveAnchorVideosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveAnchorVideosController());
  }
}
