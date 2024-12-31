import 'package:get/get.dart';

import 'vochat_login_controller.dart';

class VochatLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatLoginController());
  }
}
