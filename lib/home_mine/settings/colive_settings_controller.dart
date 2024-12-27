import 'package:get/get.dart';
import 'package:colive/services/config/colive_app_config.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/routes/colive_routes.dart';

import '../../services/widgets/dialogs/colive_language_dialog.dart';
import 'colive_settings_state.dart';

class ColiveSettingsController extends GetxController {
  final state = ColiveSettingsState();

  @override
  void onInit() {
    _initState();
    super.onInit();
  }

  void _initState() {
    state.dataList = [
      ColiveSettingItem('colive_choose_language', _onTapLanguage),
      ColiveSettingItem('colive_about_us', () {
        Get.toNamed(ColiveRoutes.aboutUs);
      }),
      ColiveSettingItem('colive_privacy_policy', _onTapPrivacyPolicy),
      ColiveSettingItem('colive_term_of_service', _onTapTermsOfService),
      ColiveSettingItem('colive_delete_account', _onTapDeleteAccount),
      ColiveSettingItem('colive_logout', _onTapLogout),
    ];
  }

  void _onTapPrivacyPolicy() {
    Get.toNamed(
      ColiveRoutes.web,
      arguments: {
        'title': 'colive_privacy_policy'.tr,
        'url': ColiveAppConfig.privacyPolicyUrl,
      },
    );
  }

  void _onTapTermsOfService() {
    Get.toNamed(
      ColiveRoutes.web,
      arguments: {
        'title': 'colive_term_of_service'.tr,
        'url': ColiveAppConfig.termsOfServiceUrl,
      },
    );
  }

  void _onTapLanguage() {
    ColiveDialogUtil.showDialog(const ColiveLanguageDialog());
  }

  void _onTapDeleteAccount() async {
    final result = await ColiveDialogUtil.showDialog(
      ColiveConfirmDialog(
        title: 'colive_delete_account'.tr,
        content: 'colive_delete_account_tips'.tr,
      ),
    );
    if (result == null || !result) return;
    ColiveProfileManager.instance.deleteAccount();
  }

  void _onTapLogout() async {
    final result = await ColiveDialogUtil.showDialog(
      ColiveConfirmDialog(
        title: 'colive_logout'.tr,
        content: 'colive_logout_tips'.tr,
      ),
    );
    if (result == null || !result) return;
    ColiveProfileManager.instance.logout();
  }
}
