import 'package:get/get.dart';

import 'colive_edit_profile_controller.dart';

class ColiveEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveEditProfileController());
  }
}
