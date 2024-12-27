import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';

import '../common/preference/colive_preference.dart';
import '../services/api/colive_api_client.dart';
import '../services/config/colive_app_config.dart';
import '../services/managers/colive_analytics_manager.dart';
import '../services/managers/colive_event_logger.dart';
import '../services/managers/colive_profile_manager.dart';
import '../services/routes/colive_routes.dart';
import '/common/utils/colive_loading_util.dart';
import '../services/extensions/colive_api_response_ext.dart';
import 'colive_login_state.dart';
import 'widgets/colive_account_login_dialog.dart';

class ColiveLoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = ColiveLoginState();
  final _apiClient = Get.find<ColiveApiClient>();
  late final AnimationController animationController;

  @override
  void onInit() {
    state.isAcceptPrivacyPolicyObs.value =
        ColiveAppPreferenceExt.acceptPrivacyPolicy;
    const duration = Duration(milliseconds: 500);
    animationController = AnimationController(vsync: this, duration: duration);
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void onChangeApiServer() async {
    if (!ColiveAppConfig.enableTestLogin) return;
    final isProductionServer = ColiveAppPreference.isProductionServer;
    String message = "";
    if (isProductionServer) {
      ColiveAppPreference.isProductionServer = false;
      message = "切换成测试服,退出App重新进入";
    } else {
      ColiveAppPreference.isProductionServer = true;
      message = "切换成正式服,退出App重新进入";
    }
    final result = await ColiveDialogUtil.showDialog(ColiveConfirmDialog(
      content: message,
      onlyConfirm: true,
    ));
    if (result == null) return;
    exit(0);
  }

  void onAccountLogin() async {
    if (!ColiveAppConfig.enableTestLogin) return;
    final arguments = await Get.dialog(const ColiveAccountLoginDialog());
    if (arguments == null || arguments is! Map<String, String>) return;
    final userId = arguments['userId'] ?? '';
    final password = arguments['password'] ?? '';
    if (userId.isEmpty || password.isEmpty) {
      ColiveLoadingUtil.showToast('UserId or password can not be empty');
      return;
    }
    try {
      ColiveLoadingUtil.show();
      await loginWithCustomCode(
        customCode: userId,
        password: password,
        loginMethod: 'acccount',
      );
    } catch (e) {
      ColiveEventLogger.instance.onLoginFailed('onAccountLogin', e.toString());
    } finally {
      ColiveLoadingUtil.dismiss();
    }
  }

  /// quick login
  Future<void> onQuickLogin() async {
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      ColiveLoadingUtil.show();
      final network = ColiveAppPreferenceExt.afNetwork;
      final result = await _apiClient.fetchVisitorAccount(network).response;
      if (result.isSuccess && result.data != null) {
        await loginWithCustomCode(
          customCode: result.data!.customCode.toString(),
          password: result.data!.password,
          loginMethod: 'fast',
        );
      } else {
        ColiveLoadingUtil.showToast(
            result.msg.isNotEmpty ? result.msg : 'colive_login_failed'.tr);
        ColiveEventLogger.instance
            .onLoginFailed('fetchVisitorAccount', "api: ${result.msg}");
      }
    } catch (e) {
      ColiveEventLogger.instance.onLoginFailed('onQuickLogin', e.toString());
    } finally {
      ColiveLoadingUtil.dismiss();
    }
  }

  Future<void> loginWithCustomCode({
    required String customCode,
    required String password,
    required String loginMethod,
  }) async {
    final network = ColiveAppPreferenceExt.afNetwork;
    final apiClient = Get.find<ColiveApiClient>();
    final result = await apiClient
        .loginWithCustomCode(customCode, password, network)
        .response;
    if (result.isSuccess && result.data != null) {
      final user = result.data?.user;
      final token = result.data?.token ?? '';
      final msg = result.data?.msg;
      if (msg != null && (user == null || token.isEmpty)) {
        ColiveDialogUtil.showDialog(ColiveConfirmDialog(
            title: msg.title, content: msg.reason ?? '', onlyConfirm: true));
        return;
      }
      await ColiveProfileManager.instance.login(result.data!);
      ColiveEventLogger.instance.onLoginSuccess(loginMethod);
      if (result.data!.isNewUser) {
        ColiveAnalyticsManager.instance.logEvent(
          key: 'Registration',
          value: {
            'registration_method': loginMethod,
            'event_user_id': result.data!.user!.id.toString(),
          },
        );
      }
      ColiveAnalyticsManager.instance.logEvent(
        key: 'Login',
        value: {'login_method': loginMethod},
      );
    } else {
      ColiveLoadingUtil.showToast('colive_login_failed'.tr);
      ColiveEventLogger.instance
          .onLoginFailed(loginMethod, "api: ${result.msg}");
    }
  }

  Future<void> onGoogleLogin() async {
    if (!ColiveAppConfig.enableAnalytics) {
      ColiveLoadingUtil.showToast('非Production环境不要访问Google');
      return;
    }
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      ColiveLoadingUtil.show();
      GoogleSignIn googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final idToken = googleAuth.idToken ?? '';
      final avatar = googleUser.photoUrl ?? '';
      final network = ColiveAppPreferenceExt.afNetwork;
      final result =
          await _apiClient.loginWithGoogle(idToken, avatar, network).response;
      if (result.isSuccess && result.data != null) {
        final user = result.data?.user;
        final token = result.data?.token ?? '';
        final msg = result.data?.msg;
        if (msg != null && (user == null || token.isEmpty)) {
          ColiveDialogUtil.showDialog(ColiveConfirmDialog(
              title: msg.title, content: msg.reason ?? '', onlyConfirm: true));
          return;
        }
        await ColiveProfileManager.instance.login(result.data!);

        ColiveEventLogger.instance.onLoginSuccess('google');
        if (result.data!.isNewUser) {
          ColiveAnalyticsManager.instance.logEvent(
            key: 'Registration',
            value: {
              'registration_method': 'google',
              'event_user_id': result.data!.user!.id.toString(),
            },
          );
        }
        ColiveAnalyticsManager.instance.logEvent(
          key: 'Login',
          value: {'login_method': 'google'},
        );
      } else {
        ColiveLoadingUtil.showToast('colive_login_failed'.tr);
        ColiveEventLogger.instance
            .onLoginFailed('google', "api: ${result.msg}");
      }
    } catch (e) {
      ColiveEventLogger.instance.onLoginFailed('onGoogleLogin', e.toString());
    } finally {
      ColiveLoadingUtil.dismiss();
    }
  }

  Future<void> onAppleLogin() async {
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      ColiveLoadingUtil.show();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final code = credential.authorizationCode;
      final uid = credential.userIdentifier ?? '';
      final network = ColiveAppPreferenceExt.afNetwork;
      final result =
          await _apiClient.loginWithApple(code, uid, network).response;
      if (result.isSuccess && result.data != null) {
        final user = result.data?.user;
        final token = result.data?.token ?? '';
        final msg = result.data?.msg;
        if (msg != null && (user == null || token.isEmpty)) {
          ColiveDialogUtil.showDialog(ColiveConfirmDialog(
              title: msg.title, content: msg.reason ?? '', onlyConfirm: true));
          return;
        }
        await ColiveProfileManager.instance.login(result.data!);

        ColiveEventLogger.instance.onLoginSuccess('apple');
        if (result.data!.isNewUser) {
          ColiveAnalyticsManager.instance.logEvent(
            key: 'Registration',
            value: {
              'registration_method': 'apple',
              'event_user_id': result.data!.user!.id.toString(),
            },
          );
        }
        ColiveAnalyticsManager.instance.logEvent(
          key: 'Login',
          value: {'login_method': 'apple'},
        );
      } else {
        ColiveLoadingUtil.showToast('colive_login_failed'.tr);
        ColiveEventLogger.instance.onLoginFailed('apple', "api: ${result.msg}");
      }
    } catch (e) {
      ColiveEventLogger.instance.onLoginFailed('onAppleLogin', e.toString());
    } finally {
      ColiveLoadingUtil.dismiss();
    }
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

  void tapAgree() {
    state.isAcceptPrivacyPolicyObs.value =
        !state.isAcceptPrivacyPolicyObs.value;
    ColiveAppPreferenceExt.acceptPrivacyPolicy =
        state.isAcceptPrivacyPolicyObs.value;
  }
}
