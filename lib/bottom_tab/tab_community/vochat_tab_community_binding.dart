import 'package:get/get.dart';

import 'vochat_tab_community_controller.dart';

class VochatTabCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VochatTabCommunityController());
  }
}
