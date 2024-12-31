import 'package:get/get.dart';

import 'vochat_media_controller.dart';

class VochatMediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatMediaController());
  }
}
