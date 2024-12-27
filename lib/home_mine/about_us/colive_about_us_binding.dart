import 'package:get/get.dart';

import 'colive_about_us_controller.dart';

class ColiveAboutUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveAboutUsController());
  }
}
