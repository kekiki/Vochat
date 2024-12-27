import 'dart:io';

import 'package:dio/dio.dart';

/// Interceptor
class ColiveRetryOnConnectionChangeInterceptor extends Interceptor {
  final Dio dio;

  ColiveRetryOnConnectionChangeInterceptor({
    required this.dio,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetryOnHttpException(err)) {
      try {
        try {
          final response = await _DioHttpRequestRetry(dio: dio)
              .requestRetry(err.requestOptions);
          handler.resolve(response);
        } catch (e) {
          handler.next(err);
        }
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetryOnHttpException(DioException err) {
    if (err.type != DioExceptionType.unknown) return false;
    final exception = err.error;
    if (exception is! HttpException) return false;
    return exception.message
        .contains("Connection closed before full header was received");
  }
}

class _DioHttpRequestRetry {
  final Dio dio;

  _DioHttpRequestRetry({required this.dio});

  Future<Response> requestRetry(RequestOptions requestOptions) async {
    return dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        contentType: requestOptions.contentType,
        headers: requestOptions.headers,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        followRedirects: requestOptions.followRedirects,
        listFormat: requestOptions.listFormat,
        maxRedirects: requestOptions.maxRedirects,
        method: requestOptions.method,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        responseType: requestOptions.responseType,
        validateStatus: requestOptions.validateStatus,
      ),
    );
  }
}
