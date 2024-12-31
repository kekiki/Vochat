import 'package:client_information/client_information.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vochat/common/i18n/vochat_local_translations.dart';

import '../../app_macros/vochat_app_macros.dart';
import '../../common/preference/vochat_preference.dart';
import '../../services/managers/vochat_event_logger.dart';

class VochatHeaderInterceptor extends Interceptor {
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
    final lang = VochatLocalTranslationLanguage.defaultLocale.languageCode;
    final syslang = Get.deviceLocale?.languageCode ?? 'en';
    String referrer = VochatPreference.installReferrer;

    final query = {
      'os_version': osVersion,
      'lang': lang,
      'syslang': syslang,
      'system': system,
      'deviceid': deviceId,
      'version': version,
      'package': packageName,
      'app': VochatAppMacros.appName,
      'userId': VochatPreference.userId,
      'token': VochatPreference.token,
      "googlePlay": 'installReferrer=$referrer',
    };

    return query;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    VochatEventLogger.instance.onApiError(err.requestOptions.path, err.error);
  }
}
