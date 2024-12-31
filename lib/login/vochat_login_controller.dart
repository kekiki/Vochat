import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../app_macros/vochat_app_macros.dart';
import '../common/api/vochat_api_client.dart';
import '../common/preference/vochat_preference.dart';
import '../common/routes/vochat_routes.dart';
import '../common/widgets/dialogs/vochat_confirm_dialog.dart';
import '../common/widgets/dialogs/vochat_dialog_util.dart';
import '/common/utils/vochat_loading_util.dart';
import 'managers/vochat_profile_manager.dart';
import 'vochat_login_state.dart';
import 'widgets/vochat_perfect_info_page.dart';

class VochatLoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = VochatLoginState();
  final _apiClient = Get.find<VochatApiClient>();
  late final AnimationController animationController;

  @override
  void onInit() {
    state.isAcceptPrivacyPolicyObs.value = VochatPreference.acceptPrivacyPolicy;
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
    if (!VochatAppMacros.enableTestLogin) return;
    final isProductionServer = VochatPreference.isProductionServer;
    String message = "";
    if (isProductionServer) {
      VochatPreference.isProductionServer = false;
      message = "切换成测试服,退出App重新进入";
    } else {
      VochatPreference.isProductionServer = true;
      message = "切换成正式服,退出App重新进入";
    }
    final result = await VochatDialogUtil.showDialog(VochatConfirmDialog(
      content: message,
      onlyConfirm: true,
    ));
    if (result == null) return;
    exit(0);
  }

  /// quick login
  Future<void> onQuickLogin() async {
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      VochatLoadingUtil.show();
      final result = await _apiClient.guestLogin().response;
      if (result.isSuccess && result.data != null) {
        final dataModel = result.data!;
        if (dataModel.isNoInformation) {
          Get.to(() => const VochatPerfectInfoPage());
        } else {
          VochatProfileManager.instance.login(dataModel);
        }
      } else {
        VochatLoadingUtil.showToast(
            result.msg.isNotEmpty ? result.msg : 'vochat_failed'.tr);
      }
    } catch (e) {
      VochatLoadingUtil.showToast('vochat_failed'.tr);
    } finally {
      VochatLoadingUtil.dismiss();
    }
  }

  Future<void> onGoogleLogin() async {
    if (!VochatAppMacros.enableAnalytics) {
      VochatLoadingUtil.showToast('非Production环境不要访问Google');
      return;
    }
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      VochatLoadingUtil.show();
      GoogleSignIn googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final token = googleAuth.idToken ?? '';
      final avatar = googleUser.photoUrl ?? '';
      final result =
          await _apiClient.googleLogin(token: token, avatar: avatar).response;
      if (result.isSuccess && result.data != null) {
        final dataModel = result.data!;
        if (dataModel.isNoInformation) {
          Get.to(() => const VochatPerfectInfoPage());
        } else {
          VochatProfileManager.instance.login(dataModel);
        }
      } else {
        VochatLoadingUtil.showToast(
            result.msg.isNotEmpty ? result.msg : 'vochat_failed'.tr);
      }
    } catch (e) {
      VochatLoadingUtil.showToast('vochat_failed'.tr);
    } finally {
      VochatLoadingUtil.dismiss();
    }
  }

  Future<void> onAppleLogin() async {
    if (!state.isAcceptPrivacyPolicyObs.value) {
      animationController.forward();
      return;
    }

    try {
      VochatLoadingUtil.show();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final code = credential.authorizationCode;
      final uid = credential.userIdentifier ?? '';
      final result = await _apiClient
          .appleLogin(appleUserId: uid, authorizationCode: code)
          .response;
      if (result.isSuccess && result.data != null) {
        final dataModel = result.data!;
        if (dataModel.isNoInformation) {
          Get.to(() => const VochatPerfectInfoPage());
        } else {
          VochatProfileManager.instance.login(dataModel);
        }
      } else {
        VochatLoadingUtil.showToast(
            result.msg.isNotEmpty ? result.msg : 'vochat_failed'.tr);
      }
    } catch (e) {
      VochatLoadingUtil.showToast('vochat_failed'.tr);
    } finally {
      VochatLoadingUtil.dismiss();
    }
  }

  void onTapPrivacyPolicy() {
    Get.toNamed(
      VochatRoutes.web,
      arguments: {
        'title': 'vochat_privacy_policy'.tr,
        'url': VochatAppMacros.privacyPolicyUrl,
      },
    );
  }

  void onTapTermsOfService() {
    Get.toNamed(
      VochatRoutes.web,
      arguments: {
        'title': 'vochat_user_agreement'.tr,
        'url': VochatAppMacros.termsOfServiceUrl,
      },
    );
  }

  void tapAgree() {
    state.isAcceptPrivacyPolicyObs.value =
        !state.isAcceptPrivacyPolicyObs.value;
    VochatPreference.acceptPrivacyPolicy = state.isAcceptPrivacyPolicyObs.value;
  }
}
