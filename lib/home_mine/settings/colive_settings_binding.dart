import 'package:get/get.dart';

import 'colive_settings_controller.dart';

class ColiveSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveSettingsController());
  }
}
