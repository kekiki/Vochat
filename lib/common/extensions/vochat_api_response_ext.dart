import 'dart:async';

import '../../login/managers/vochat_profile_manager.dart';
import '../../app_macros/vochat_app_macros.dart';
import '../logger/vochat_log_util.dart';
import '../../services/models/vochat_api_response.dart';

extension VochatFutureExt<T> on Future<VochatApiResponse<T>> {
  Future<VochatApiResponse<T>> get response async {
    Completer<VochatApiResponse<T>> completer = Completer();
    then((response) {
      if (response.isTokenExpired) {
        VochatProfileManager.instance.logout();
      }
      completer.complete(response);
    }, onError: (Object error, StackTrace stackTrace) {
      if (VochatAppMacros.enableApiLog) {
        VochatLogUtil.e("onApiError", "$error\n$stackTrace");
      }
      final response =
          VochatApiResponse<T>(code: -1, msg: error.toString(), data: null);
      completer.complete(response);
    });
    return completer.future;
  }

  Future<VochatApiResponse<T>> retryResult(
      {int maxCount = 3, int delay = 3000}) async {
    assert(maxCount >= 1);
    VochatApiResponse<T>? currentResult;
    for (int i = 0; i < maxCount; i++) {
      currentResult = await response;
      if (currentResult.isSuccess) return currentResult;
      await Future.delayed(Duration(milliseconds: delay));
    }
    return currentResult!;
  }
}
