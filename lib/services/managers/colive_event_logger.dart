import 'dart:async';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:get/get.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

import '../../common/logger/colive_log_util.dart';
import '../config/colive_app_config.dart';
import '../extensions/colive_preference_ext.dart';
import 'colive_profile_manager.dart';

class ColiveEventLogger {
  ColiveEventLogger._internal();
  static ColiveEventLogger? _instance;
  static ColiveEventLogger get instance =>
      _instance ??= ColiveEventLogger._internal();

  static final facebookAppEvents = FacebookAppEvents();

  Future<void> init() async {
    // google referrer
    await _fetchInstallReferrer();
    // facebook
    facebookAppEvents.setAutoLogAppEventsEnabled(true);
    facebookAppEvents.setAdvertiserTracking(enabled: true);
  }

  Future<void> _fetchInstallReferrer() async {
    if (GetPlatform.isAndroid) {
      try {
        ReferrerDetails referrerDetails =
            await AndroidPlayInstallReferrer.installReferrer;
        String tempRef = referrerDetails.installReferrer ?? "";
        ColiveAppPreferenceExt.installReferrer = Uri.encodeComponent(tempRef);
      } catch (e) {
        ColiveAppPreferenceExt.installReferrer = 'Failed: $e';
      }
    }
  }

  void _logEvent(String eventName, {Map<String, Object> params = const {}}) {
    if (!ColiveAppConfig.enableAnalytics) {
      ColiveLogUtil.i("[$eventName]", params.toString());
    }
  }

//   //////////////////////////////////////////////////////////////////////////////////
//   ///////////////////////////// Login
//   //////////////////////////////////////////////////////////////////////////////////

  Future<void> login() async {
    final userId = ColiveProfileManager.instance.userInfo.id;
    facebookAppEvents.setUserID('$userId');
  }

  Future<void> logout() async {
    facebookAppEvents.clearUserID();
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
