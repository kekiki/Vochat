import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../services/extensions/colive_preference_ext.dart';
import '../common/preference/colive_preference.dart';
import '../services/routes/colive_routes.dart';

class ColiveSplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    if (ColiveAppPreference.isAppFirstLaunch) {
      ColiveAppPreference.isAppFirstLaunch = false;
    }

    final apiToken = ColiveAppPreferenceExt.apiToken;
    if (apiToken.isEmpty) {
      Get.offAndToNamed(ColiveRoutes.login);
    } else {
      Get.offAndToNamed(ColiveRoutes.home);
    }

    FlutterNativeSplash.remove();
  }
}
