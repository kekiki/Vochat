import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:datatower_ai_core_flutter/api/dt.dart';
import 'package:datatower_ai_core_flutter/api/dt_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:get/get.dart';

import '../extensions/colive_preference_ext.dart';
import '../config/colive_app_config.dart';

class ColiveAnalyticsManager {
  ColiveAnalyticsManager._internal();
  static ColiveAnalyticsManager? _instance;
  static ColiveAnalyticsManager get instance =>
      _instance ??= ColiveAnalyticsManager._internal();

  AppsflyerSdk? _appsflyerSdk;

  Future<void> init() async {
    if (ColiveAppConfig.enableAnalytics) {
      DT.initSDK(ColiveAppConfig.dtAppId, ColiveAppConfig.dtUrl);
      DTAnalytics.getDataTowerId().then((value) {
        if (value == null) return;
        ColiveAppPreferenceExt.dtId = value;
      });

      AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: ColiveAppConfig.afDevKey,
        appId: ColiveAppConfig.afAppId,
      );

      _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
      await _appsflyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );

      final afUid = await _appsflyerSdk?.getAppsFlyerUID() ?? '';
      _appsflyerSdk?.onInstallConversionData((res) {
        final String status = res['payload']['af_status'] ?? '';
        final network =
            status.isEmpty || status.toLowerCase() == 'organic' ? '1' : '2';
        ColiveAppPreferenceExt.afNetwork = network;
        ColiveLogUtil.d('AppsflyerSdk', res.toString());
      });

      DTAnalytics.setAppsFlyerId(afUid);
      if (GetPlatform.isAndroid) {
        final appInstanceId = await FirebaseAnalytics.instance.appInstanceId;
        DTAnalytics.setFirebaseAppInstanceId(appInstanceId);
      }

      // _testLogPurchase();
    }
  }

  // void _testLogPurchase() {
  //   logEvent(
  //       key: 'PurchaseDiamond', value: {'currency': 'USD', 'price': '3.99'});
  //   logEvent(key: 'PurchaseVip', value: {'currency': 'USD', 'price': '3.99'});
  // }

  void logEvent(
      {required String key, Map<String, Object?> value = const {}}) async {
    if (ColiveAppConfig.enableAnalytics) {
      try {
        DTAnalytics.trackEvent(key, value);
        final result = await _appsflyerSdk?.logEvent(key, value);
        ColiveLogUtil.d('appsflyerEvent', result.toString());
      } on Exception catch (e) {
        ColiveLogUtil.d('appsflyerEvent', e.toString());
      }
    }
  }
}
