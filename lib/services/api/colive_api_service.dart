import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';

import '../config/colive_app_config.dart';
import 'colive_api_client.dart';
import 'colive_header_interceptor.dart';
import 'colive_logger_interceptor.dart';
import 'colive_retry_intercepter.dart';

class ColiveApiService extends GetxService {
  Future<ColiveApiClient> init() async {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: ColiveAppConfig.apiUrl,
      ),
    );

    dio.interceptors.add(ColiveHeaderInterceptor());
    dio.transformer = SyncTransformer();

    dio.interceptors.add(ColiveLoggerInterceptor(requestHeader: true));
    dio.interceptors.add(ColiveRetryOnConnectionChangeInterceptor(dio: dio));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return ColiveApiClient(dio);
  }
}
