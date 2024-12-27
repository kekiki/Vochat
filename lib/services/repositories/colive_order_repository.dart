import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';

import '../../common/logger/colive_log_util.dart';
import '../api/colive_api_client.dart';
import '../api/colive_header_interceptor.dart';
import '../api/colive_logger_interceptor.dart';
import '../api/colive_retry_intercepter.dart';
import '../config/colive_app_config.dart';
import '../database/colive_database.dart';
import '../models/colive_order_item_model.dart';
import '../models/colive_product_base_model.dart';

class ColiveOrderRepository {
  static const _tag = "OrderRepository";
  final ColiveApiClient _apiClient = Get.find<ColiveApiClient>();
  final ColiveDatabase _database = Get.find<ColiveDatabase>();

  Future<ColiveOrderItemModel?> createOrder(ColiveProductItemModel product,
      {String? channelId}) async {
    final userId = ColiveAppPreferenceExt.userId;
    final payId = product.id.toString();
    final afId = ColiveAppPreferenceExt.afid;
    final afAdid = ColiveAppPreferenceExt.adid;
    final dtId = ColiveAppPreferenceExt.dtId;
    final data = {
      'user_id': userId,
      'pay_list_id': payId,
      'channel_price_id': channelId ?? '',
      'af_id': afId,
      'af_adid': afAdid,
      'dt_id': dtId,
    };

    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: ColiveAppConfig.payUrl,
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

    try {
      final result = await dio.post(kApiUrlCreateOrder, data: data);
      if (result.statusCode == 200 && result.data != null) {
        late ColiveOrderItemModel order;
        if (result.data! is String) {
          final orderMap = jsonDecode(result.data);
          if (orderMap['code'] != 200) {
            return null;
          }
          order = ColiveOrderItemModel.fromJson(orderMap['data']);
        } else {
          if (result.data['code'] != 200) {
            return null;
          }
          order = ColiveOrderItemModel.fromJson(result.data['data']);
        }
        _database.orderDao.insertOrder(order);
        return order;
      } else {
        ColiveLogUtil.e(_tag, 'createOrder error: ${result.statusMessage}');
      }
    } catch (e) {
      ColiveLogUtil.e(_tag, 'createOrder error: ${e.toString()}');
    }

    return null;
  }

  Future<ColiveOrderItemModel?> queryOrder(String productId) async {
    return await _database.orderDao.findOrderByProductId(productId);
  }

  Future<void> deleteOrder(String productId) async {
    return await _database.orderDao.deleteOrderByProductId(productId);
  }

  Future<bool> verifyOrderIOS({
    required String receipt,
    required String orderId,
    required String transactionId,
  }) async {
    final result = await _apiClient
        .verifyOrderIOS(receipt, orderId, transactionId)
        .response;
    return result.isSuccess;
  }

  Future<bool> verifyOrderAndroid({
    required String purchaseToken,
    required String packageName,
    required String productId,
  }) async {
    final result = await _apiClient
        .verifyOrderAndroid(purchaseToken, packageName, productId)
        .response;
    return result.isSuccess;
  }
}
