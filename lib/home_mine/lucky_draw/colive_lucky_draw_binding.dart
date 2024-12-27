import 'package:get/get.dart';

import 'colive_lucky_draw_controller.dart';

class ColiveLuckyDrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveLuckyDrawController());
  }
}
