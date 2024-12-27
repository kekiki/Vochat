import 'package:get/get.dart';

import 'colive_home_anchors_controller.dart';
import 'widgets/colive_anchor_follow_controller.dart';
import 'widgets/colive_anchor_popular_controller.dart';

class ColiveHomeAnchorsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveHomeAnchorsController());
    Get.lazyPut(() => ColiveAnchorPopularController());
    Get.lazyPut(() => ColiveAnchorFollowController());
  }
}
