import 'package:get/get.dart';

import 'colive_media_controller.dart';

class ColiveMediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveMediaController());
  }
}
