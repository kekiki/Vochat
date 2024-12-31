import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:vochat/common/extensions/vochat_string_ext.dart';

import '../../app_macros/vochat_app_macros.dart';
import 'vochat_api_client.dart';
import 'vochat_header_interceptor.dart';
import 'vochat_logger_interceptor.dart';
import 'vochat_retry_intercepter.dart';

class VochatApiService extends GetxService {
  Future<VochatApiClient> init() async {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: VochatAppMacros.apiUrl,
      ),
    );

    dio.interceptors.add(VochatHeaderInterceptor());
    dio.transformer = _Transformer();

    dio.interceptors.add(VochatLoggerInterceptor(requestHeader: true));
    dio.interceptors.add(VochatRetryOnConnectionChangeInterceptor(dio: dio));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return VochatApiClient(dio);
  }
}

class _Transformer extends SyncTransformer {
  _Transformer() : super(jsonDecodeCallback: (text) => _decodeJson(text));
}

FutureOr<dynamic> _decodeJson(String text) {
  final Map response = jsonDecode(text);
  final data = response['data'];
  if (data != null) {
    final String dataString = data;
    final jsonData = dataString.aesDecode;
    response['data'] = jsonDecode(jsonData);
  }
  return response;
}
