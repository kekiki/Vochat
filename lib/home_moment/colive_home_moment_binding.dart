import 'package:get/get.dart';

import 'colive_home_moment_controller.dart';
import 'widgets/colive_moment_hot_controller.dart';
import 'widgets/colive_moment_mine_controller.dart';

class ColiveHomeMomentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveHomeMomentController());
    Get.lazyPut(() => ColiveMomentMineController());
    Get.lazyPut(() => ColiveMomentHotController());
  }
}
