import 'dart:async';

import 'package:colive/services/managers/colive_profile_manager.dart';

import '../../common/logger/colive_log_util.dart';
import '../config/colive_app_config.dart';
import '../models/colive_api_response.dart';

extension ColiveFutureExt<T> on Future<ColiveApiResponse<T>> {
  Future<ColiveApiResponse<T>> get response async {
    Completer<ColiveApiResponse<T>> completer = Completer();
    then((response) {
      if (response.isTokenExpired || response.isAccountBanned) {
        ColiveProfileManager.instance.logout();
      }
      completer.complete(response);
    }, onError: (Object error, StackTrace stackTrace) {
      if (ColiveAppConfig.enableApiLog) {
        ColiveLogUtil.e("onApiError", "$error\n$stackTrace");
      }
      final response =
          ColiveApiResponse<T>(code: -1, msg: error.toString(), data: null);
      completer.complete(response);
    });
    return completer.future;
  }

  Future<ColiveApiResponse<T>> retryResult(
      {int maxCount = 3, int delay = 3000}) async {
    assert(maxCount >= 1);
    ColiveApiResponse<T>? currentResult;
    for (int i = 0; i < maxCount; i++) {
      currentResult = await response;
      if (currentResult.isSuccess) return currentResult;
      await Future.delayed(Duration(milliseconds: delay));
    }
    return currentResult!;
  }
}
