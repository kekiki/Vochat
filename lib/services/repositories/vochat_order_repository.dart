import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';

import '../../app_macros/vochat_app_macros.dart';
import '../../common/logger/vochat_log_util.dart';
import '../../common/preference/vochat_preference.dart';
import '../../common/api/vochat_api_client.dart';
import '../../common/api/vochat_header_interceptor.dart';
import '../../common/api/vochat_logger_interceptor.dart';
import '../../common/api/vochat_retry_intercepter.dart';
import '../../common/database/vochat_database.dart';
import '../models/vochat_order_item_model.dart';
import '../models/vochat_product_base_model.dart';

class VochatOrderRepository {
  static const _tag = "OrderRepository";
  final VochatApiClient _apiClient = Get.find<VochatApiClient>();
  final VochatDatabase _database = Get.find<VochatDatabase>();

  Future<VochatOrderItemModel?> createOrder(VochatProductItemModel product,
      {String? channelId}) async {
    final userId = VochatPreference.userId;
    final payId = product.id.toString();
    final afId = VochatPreference.afid;
    final afAdid = VochatPreference.adid;
    final dtId = VochatPreference.dtId;
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
        baseUrl: VochatAppMacros.payUrl,
      ),
    );

    dio.interceptors.add(VochatHeaderInterceptor());
    dio.transformer = SyncTransformer();

    dio.interceptors.add(VochatLoggerInterceptor(requestHeader: true));
    dio.interceptors.add(VochatRetryOnConnectionChangeInterceptor(dio: dio));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    try {
      final result = await dio.post(kApiUrlCreateOrder, data: data);
      if (result.statusCode == 200 && result.data != null) {
        late VochatOrderItemModel order;
        if (result.data! is String) {
          final orderMap = jsonDecode(result.data);
          if (orderMap['code'] != 200) {
            return null;
          }
          order = VochatOrderItemModel.fromJson(orderMap['data']);
        } else {
          if (result.data['code'] != 200) {
            return null;
          }
          order = VochatOrderItemModel.fromJson(result.data['data']);
        }
        _database.orderDao.insertOrder(order);
        return order;
      } else {
        VochatLogUtil.e(_tag, 'createOrder error: ${result.statusMessage}');
      }
    } catch (e) {
      VochatLogUtil.e(_tag, 'createOrder error: ${e.toString()}');
    }

    return null;
  }

  Future<VochatOrderItemModel?> queryOrder(String productId) async {
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
