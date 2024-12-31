import 'dart:async';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:get/get.dart';
// import 'package:facebook_app_events/facebook_app_events.dart';

import '../../login/managers/vochat_profile_manager.dart';
import '../../app_macros/vochat_app_macros.dart';
import '../../common/logger/vochat_log_util.dart';
import '../../common/preference/vochat_preference.dart';

class VochatEventLogger {
  VochatEventLogger._internal();
  static VochatEventLogger? _instance;
  static VochatEventLogger get instance =>
      _instance ??= VochatEventLogger._internal();

  // static final facebookAppEvents = FacebookAppEvents();

  Future<void> init() async {
    // google referrer
    await _fetchInstallReferrer();
    // facebook
    // facebookAppEvents.setAutoLogAppEventsEnabled(true);
    // facebookAppEvents.setAdvertiserTracking(enabled: true);
  }

  Future<void> _fetchInstallReferrer() async {
    if (GetPlatform.isAndroid) {
      try {
        ReferrerDetails referrerDetails =
            await AndroidPlayInstallReferrer.installReferrer;
        String tempRef = referrerDetails.installReferrer ?? "";
        VochatPreference.installReferrer = Uri.encodeComponent(tempRef);
      } catch (e) {
        VochatPreference.installReferrer = 'Failed: $e';
      }
    }
  }

  void _logEvent(String eventName, {Map<String, Object> params = const {}}) {
    if (!VochatAppMacros.enableAnalytics) {
      VochatLogUtil.i("[$eventName]", params.toString());
    }
  }

//   //////////////////////////////////////////////////////////////////////////////////
//   ///////////////////////////// Login
//   //////////////////////////////////////////////////////////////////////////////////

  Future<void> login() async {
    // final userId = VochatProfileManager.instance.userInfo.id;
    // facebookAppEvents.setUserID('$userId');
  }

  Future<void> logout() async {
    // facebookAppEvents.clearUserID();
  }

//   //////////////////////////////////////////////////////////////////////////////////
//   ///////////////////////////// AppOpen
//   //////////////////////////////////////////////////////////////////////////////////

  void onAppOpen() {
    _logEvent('onAppOpen');
  }

  void onFirstOpen() {
    _logEvent('onFirstOpen');
  }

//   //////////////////////////////////////////////////////////////////////////////////
//   ///////////////////////////// Error
//   //////////////////////////////////////////////////////////////////////////////////

  void reportError(String message) {
    _logEvent("Error: $message");
  }

  void onApiError(String api, Object? error) {
    final params = {
      'api': api,
      'error': error.toString(),
    };
    _logEvent('onApiError', params: params);
  }

//   //////////////////////////////////////////////////////////////////////////////////
//   ///////////////////////////// LoginPage
//   //////////////////////////////////////////////////////////////////////////////////

  void onLoginFailed(String method, String reason) {
    final params = {'method': method, 'reason': reason};
    _logEvent('onLoginFailed', params: params);
  }

  void onLoginSuccess(String method) {
    final params = {'method': method};
    _logEvent('onLoginSuccess', params: params);
  }
}
