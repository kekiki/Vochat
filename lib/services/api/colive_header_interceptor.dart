import 'package:client_information/client_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:colive/services/config/colive_app_config.dart';
import 'package:colive/services/managers/colive_analytics_manager.dart';

import '../../common/preference/colive_preference.dart';
import '../extensions/colive_preference_ext.dart';
import '../managers/colive_event_logger.dart';

class ColiveHeaderInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var headers = options.headers;
    final params = await getCommonParamters();
    params.forEach((key, value) {
      headers[key] = value;
    });
    options.headers = headers;
    handler.next(options);
  }

  /// 通用参数
  Future<Map<String, Object?>> getCommonParamters() async {
    ClientInformation clientInformation = await ClientInformation.fetch();
    final packageName = clientInformation.applicationId;
    final deviceId = clientInformation.deviceId;
    final system = clientInformation.osName;
    final osVersion = clientInformation.osVersion;
    final version = clientInformation.applicationVersion;
    // final language = Get.locale?.languageCode ?? 'en';
    final country = Get.deviceLocale?.countryCode ?? 'US';
    String referrer = ColiveAppPreferenceExt.installReferrer;

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final query = {
      'type': "2", // 1主播，2用户
      'os_version': osVersion,
      // 'lang': language,
      'system': system,
      'country': country,
      'deviceId': deviceId,
      'versionName': version,
      'packageName': packageName,
      'app': ColiveAppConfig.appName,
      'deviceTimezone': currentTimeZone,
      'isOffline': ColiveAppPreference.isProductionServer ? 0 : 1,
      'platform': 2,
      'userId': ColiveAppPreferenceExt.userId,
      'token': ColiveAppPreferenceExt.apiToken,
      "googlePlay": 'installReferrer=$referrer',
    };

    return query;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    ColiveEventLogger.instance.onApiError(err.requestOptions.path, err.error);
    ColiveAnalyticsManager.instance.logEvent(key: 'ApiRequestError', value: {
      'path': err.requestOptions.path,
      'userId': ColiveAppPreferenceExt.userId,
      'error': err.toString(),
    });
  }
}
