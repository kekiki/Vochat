import 'package:client_information/client_information.dart';
import 'package:get/get.dart';

import '../../services/config/colive_app_config.dart';
import '../../services/routes/colive_routes.dart';

class ColiveAboutUsController extends GetxController {
  final versionObs = '1.0.0'.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAppVersion();
  }

  void _fetchAppVersion() async {
    final clientInformation = await ClientInformation.fetch();
    versionObs.value =
        'colive_version_%s'.trArgs([clientInformation.applicationVersion]);
  }

  void onTapPrivacyPolicy() {
    Get.toNamed(
      ColiveRoutes.web,
      arguments: {
        'title': 'colive_privacy_policy'.tr,
        'url': ColiveAppConfig.privacyPolicyUrl,
      },
    );
  }

  void onTapTermsOfService() {
    Get.toNamed(
      ColiveRoutes.web,
      arguments: {
        'title': 'colive_term_of_service'.tr,
        'url': ColiveAppConfig.termsOfServiceUrl,
      },
    );
  }
}
