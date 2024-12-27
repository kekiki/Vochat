import 'dart:io';

import 'package:get/get.dart';

import '../../common/logger/colive_log_util.dart';
import '../../common/preference/colive_preference.dart';
import '../../common/utils/colive_path_util.dart';
import '../api/colive_api_service.dart';
import '../database/colive_database_service.dart';
import '../http_overrides/colive_global_http_overrides.dart';
import '../managers/colive_event_logger.dart';
import '../managers/colive_analytics_manager.dart';
import '../repositories/colive_anchor_repository.dart';
import '../repositories/colive_card_repository.dart';
import '../repositories/colive_order_repository.dart';

class ColiveAppConfig {
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

  static const zegoAppId = 1634908274;
  static const zegoAppSign =
      'c0121bdc9e63890361bf370d34438eff045a2f3f35701cce81a064dea240bea2';

  static const privacyPolicyUrl = "https://res.melon53.com/web/privacy.html";
  static const termsOfServiceUrl = "https://res.melon53.com/web/terms.html";

  ColiveAppConfig._internal();

  static ColiveAppConfig? _instance;
  static ColiveAppConfig get instance =>
      _instance ??= ColiveAppConfig._internal();

  Future<void> initDevelop() async {
    await _initUtils();
    if (ColiveAppPreference.isProductionServer) {
      _initProductionServerConfig();
    } else {
      _initDevelopServerConfig();
    }
    await _initServices();
  }

  Future<void> initProduction() async {
    await _initUtils();
    ColiveAppPreference.isProductionServer = true;
    _initProductionServerConfig();
    await _initServices();
  }

  void _initDevelopServerConfig() {
    ColiveAppConfig.appName = 'Yuppi';
    ColiveAppConfig.apiUrl = "https://wmapi.hichat4.com";
    ColiveAppConfig.payUrl =
        "https://back.xiangyu369.com/v3/Pay/creatOrder?server=1";
    ColiveAppConfig.socketUrl = "wss://wmscoket.hichat4.com";
  }

  void _initProductionServerConfig() {
    ColiveAppConfig.appName = 'Manda';
    ColiveAppConfig.apiUrl = "https://api.livvymarket.com";
    ColiveAppConfig.payUrl = "https://back.livvymarket.com";
    ColiveAppConfig.socketUrl = "wss://socket.livvymarket.com";
  }

  Future<void> _initUtils() async {
    HttpOverrides.global = ColiveGlobalHttpOverrides();
    await ColiveAppPreference.init();
    await ColivePathUtil.init();
    await ColiveLogUtil.init();
  }

  Future<void> _initServices() async {
    await ColiveEventLogger.instance.init();
    await ColiveAnalyticsManager.instance.init();

    await Get.putAsync(() => ColiveApiService().init());
    await Get.putAsync(() => ColiveDatabaseService().init());

    Get.lazyPut(() => ColiveAnchorRepository(), fenix: true);
    Get.lazyPut(() => ColiveOrderRepository(), fenix: true);
    Get.lazyPut(() => ColiveCardRepository(), fenix: true);
  }
}
