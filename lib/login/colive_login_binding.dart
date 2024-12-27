import 'package:get/get.dart';

import 'colive_login_controller.dart';

class ColiveLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveLoginController());
  }
}
