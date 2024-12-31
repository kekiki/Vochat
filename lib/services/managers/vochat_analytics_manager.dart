// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
// import 'package:datatower_ai_core_flutter/api/dt.dart';
// import 'package:datatower_ai_core_flutter/api/dt_analytics.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:vochat/common/logger/vochat_log_util.dart';
// import 'package:get/get.dart';

// import '../../app_macros/vochat_app_macros.dart';
// import '../../common/preference/vochat_preference.dart';

// class VochatAnalyticsManager {
//   VochatAnalyticsManager._internal();
//   static VochatAnalyticsManager? _instance;
//   static VochatAnalyticsManager get instance =>
//       _instance ??= VochatAnalyticsManager._internal();

//   AppsflyerSdk? _appsflyerSdk;

//   Future<void> init() async {
//     if (VochatAppMacros.enableAnalytics) {
//       DT.initSDK(VochatAppMacros.dtAppId, VochatAppMacros.dtUrl);
//       DTAnalytics.getDataTowerId().then((value) {
//         if (value == null) return;
//         VochatPreference.dtId = value;
//       });

//       AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
//         afDevKey: VochatAppMacros.afDevKey,
//         appId: VochatAppMacros.afAppId,
//       );

//       _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
//       await _appsflyerSdk?.initSdk(
//         registerConversionDataCallback: true,
//         registerOnAppOpenAttributionCallback: true,
//         registerOnDeepLinkingCallback: true,
//       );

//       final afUid = await _appsflyerSdk?.getAppsFlyerUID() ?? '';
//       _appsflyerSdk?.onInstallConversionData((res) {
//         final String status = res['payload']['af_status'] ?? '';
//         final network =
//             status.isEmpty || status.toLowerCase() == 'organic' ? '1' : '2';
//         // VochatPreference.afNetwork = network;
//         VochatLogUtil.d('AppsflyerSdk', res.toString());
//       });

//       DTAnalytics.setAppsFlyerId(afUid);
//       if (GetPlatform.isAndroid) {
//         final appInstanceId = await FirebaseAnalytics.instance.appInstanceId;
//         DTAnalytics.setFirebaseAppInstanceId(appInstanceId);
//       }

//       // _testLogPurchase();
//     }
//   }

//   // void _testLogPurchase() {
//   //   logEvent(
//   //       key: 'PurchaseDiamond', value: {'currency': 'USD', 'price': '3.99'});
//   //   logEvent(key: 'PurchaseVip', value: {'currency': 'USD', 'price': '3.99'});
//   // }

//   void logEvent(
//       {required String key, Map<String, Object?> value = const {}}) async {
//     if (VochatAppMacros.enableAnalytics) {
//       try {
//         DTAnalytics.trackEvent(key, value);
//         final result = await _appsflyerSdk?.logEvent(key, value);
//         VochatLogUtil.d('appsflyerEvent', result.toString());
//       } on Exception catch (e) {
//         VochatLogUtil.d('appsflyerEvent', e.toString());
//       }
//     }
//   }
// }
