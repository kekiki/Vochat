import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../common/preference/vochat_preference.dart';
import '../common/routes/vochat_routes.dart';

class VochatSplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    if (VochatPreference.isAppFirstLaunch) {
      VochatPreference.isAppFirstLaunch = false;
    }

    final apiToken = VochatPreference.token;
    if (apiToken.isEmpty) {
      Get.offAndToNamed(VochatRoutes.login);
    } else {
      Get.offAndToNamed(VochatRoutes.tabs);
    }

    FlutterNativeSplash.remove();
  }
}
