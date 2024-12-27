import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

class ColiveLoadingUtil {
  ColiveLoadingUtil._internal();

  /// init EasyLoading
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return EasyLoading.init(builder: builder);
  }

  /// show loading with [status] [indicator]
  static Future<void> show({
    String? status,
    Widget? indicator,
    bool? dismissOnTap,
  }) async {
    if (EasyLoading.isShow) return;

    return await EasyLoading.show(
      status: status,
      indicator: indicator,
      dismissOnTap: dismissOnTap,
      maskType: EasyLoadingMaskType.clear,
    );
  }

  /// show progress with [value] [status], value should be 0.0 ~ 1.0.
  static Future<void> showProgress(
    double value, {
    String? status,
  }) async {
    return await EasyLoading.showProgress(
      value,
      status: status,
    );
  }

  /// showSuccess [status] [duration] [maskType]
  static Future<void> showSuccess(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) async {
    return await EasyLoading.showSuccess(
      status,
      duration: duration,
      dismissOnTap: dismissOnTap,
    );
  }

  /// showError [status] [duration] [maskType]
  static Future<void> showError(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) async {
    return EasyLoading.showError(
      status,
      duration: duration,
      dismissOnTap: dismissOnTap,
    );
  }

  /// showInfo [status] [duration] [maskType]
  static Future<void> showInfo(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) async {
    return await EasyLoading.showInfo(
      status,
      duration: duration,
      dismissOnTap: dismissOnTap,
    );
  }

  /// showToast [status] [duration] [toastPosition] [maskType]
  static Future<void> showToast(
    String status, {
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    bool? dismissOnTap,
  }) async {
    return await EasyLoading.showToast(
      status,
      duration: duration,
      toastPosition: toastPosition,
      dismissOnTap: dismissOnTap,
    );
  }

  /// dismiss loading
  static Future<void> dismiss({
    bool animation = true,
  }) async {
    return await EasyLoading.dismiss(animation: animation);
  }

  /// add loading status callback
  static void addStatusCallback(EasyLoadingStatusCallback callback) {
    return EasyLoading.addStatusCallback(callback);
  }

  /// remove single loading status callback
  static void removeCallback(EasyLoadingStatusCallback callback) {
    return EasyLoading.removeCallback(callback);
  }

  /// remove all loading status callback
  static void removeAllCallbacks() {
    return EasyLoading.removeAllCallbacks();
  }
}
