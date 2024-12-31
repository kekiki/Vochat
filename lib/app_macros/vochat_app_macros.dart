import 'dart:io';

import 'package:get/get.dart';

import '../common/api/vochat_api_service.dart';
import '../common/logger/vochat_log_util.dart';
import '../common/preference/vochat_preference.dart';
import '../common/utils/vochat_path_util.dart';
import '../common/database/vochat_database_service.dart';
import '../common/http_overrides/vochat_global_http_overrides.dart';
import '../services/managers/vochat_analytics_manager.dart';
import '../services/managers/vochat_event_logger.dart';

class VochatAppMacros {
  /// Custom
  static bool enableTestLogin = false;
  static bool enableApiLog = false;
  static bool enableAnalytics = false;

  /// Defines
  static String appName = '';
  static String apiUrl = '';
  static String payUrl = '';
  static String socketUrl = '';

  static const nimKey = 'b1cfe3dfec25f0be097aab403bd6fe63';
  static const nimSecret = 'fc9e6e85e830';

  static const dtAppId = 'dt_c26d969a4819ed07';
  static const dtUrl = 'https://report.roiquery.com';

  static const afDevKey = 'YKvTPgpt6WTLrhBcAZXdd5';
  static const afAppId = '6479290308';

  static const privacyPolicyUrl = "https://res.melon53.com/web/privacy.html";
  static const termsOfServiceUrl = "https://res.melon53.com/web/terms.html";

  VochatAppMacros._internal();

  static VochatAppMacros? _instance;
  static VochatAppMacros get instance =>
      _instance ??= VochatAppMacros._internal();

  Future<void> initDevelop() async {
    await _initUtils();
    if (VochatPreference.isProductionServer) {
      _initProductionServerConfig();
    } else {
      _initDevelopServerConfig();
    }
    await _initServices();
  }

  Future<void> initProduction() async {
    await _initUtils();
    VochatPreference.isProductionServer = true;
    _initProductionServerConfig();
    await _initServices();
  }

  void _initDevelopServerConfig() {
    VochatAppMacros.appName = 'Yuppi';
    VochatAppMacros.apiUrl = "https://wmapi.hichat4.com";
    VochatAppMacros.payUrl =
        "https://back.xiangyu369.com/v3/Pay/creatOrder?server=1";
    VochatAppMacros.socketUrl = "wss://wmscoket.hichat4.com";
  }

  void _initProductionServerConfig() {
    VochatAppMacros.appName = 'Manda';
    VochatAppMacros.apiUrl = "https://api.livvymarket.com";
    VochatAppMacros.payUrl = "https://back.livvymarket.com";
    VochatAppMacros.socketUrl = "wss://socket.livvymarket.com";
  }

  Future<void> _initUtils() async {
    HttpOverrides.global = VochatGlobalHttpOverrides();
    await VochatPreference.init();
    await VochatPathUtil.init();
    await VochatLogUtil.init();
  }

  Future<void> _initServices() async {
    await VochatEventLogger.instance.init();
    // await VochatAnalyticsManager.instance.init();

    await Get.putAsync(() => VochatApiService().init());
    await Get.putAsync(() => VochatDatabaseService().init());
  }
}
