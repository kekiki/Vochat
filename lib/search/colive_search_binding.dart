import 'package:get/get.dart';

import 'colive_search_controller.dart';

class ColiveSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveSearchController());
  }
}
