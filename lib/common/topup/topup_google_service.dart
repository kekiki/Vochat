import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:vochat/app_macros/vochat_app_macros.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';

import '../../common/logger/vochat_log_util.dart';
import '../../common/preference/vochat_preference.dart';
import '../../services/models/vochat_order_item_model.dart';
import '../../services/models/vochat_product_base_model.dart';
import '../../services/repositories/vochat_order_repository.dart';

class TopupGoogleService {
  Function(bool succeed)? _purchaseCallback;
  BillingClient? _billingClient;

  static const _tag = 'AndroidTopup';
  final _orderRepository = Get.find<VochatOrderRepository>();

  /// 单例
  factory TopupGoogleService() => _instance;
  static TopupGoogleService get instance => _instance;
  static final TopupGoogleService _instance = TopupGoogleService._();
  TopupGoogleService._() {
    listenPurchaseUpdated();
  }

  void listenPurchaseUpdated() {
    if (!VochatAppMacros.enableAnalytics) return;

    _billingClient = BillingClient((PurchasesResultWrapper purchasesResult) {
      if (purchasesResult.responseCode == BillingResponse.ok) {
        for (var purchaseWrapper in purchasesResult.purchasesList) {
          consumeAsync(purchaseWrapper);
        }
      } else {
        final code = const BillingResponseConverter()
            .toJson(purchasesResult.responseCode);
        VochatLogUtil.i(_tag, '💰 pay order verify failed [$code]');
        VochatLoadingUtil.showToast('${'vochat_failed'.tr}[$code]');
        if (_purchaseCallback != null) {
          _purchaseCallback!(false);
        }
      }
    });
  }

  //google in app purchase 结束该交易
  Future<void> consumeAsync(PurchaseWrapper purchaseWrapper,
      {bool isFixOrder = false}) async {
    if (!VochatAppMacros.enableAnalytics) return;

    //google pay 确认api 防止3天自动退款
    if (purchaseWrapper.purchaseState == PurchaseStateWrapper.purchased) {
      _billingClient?.acknowledgePurchase(purchaseWrapper.purchaseToken);
    }

    for (var sku in purchaseWrapper.products) {
      final orderInfo = await _orderRepository.queryOrder(sku);
      if (orderInfo == null) {
        VochatLogUtil.i(_tag, '💰 pay order not found');
        VochatLoadingUtil.dismiss();
        if (_purchaseCallback != null) {
          _purchaseCallback!(false);
        }
        break;
      }

      final purchaseToken = purchaseWrapper.purchaseToken;
      final isSuccess = await _orderRepository.verifyOrderAndroid(
        purchaseToken: purchaseWrapper.purchaseToken,
        packageName: purchaseWrapper.packageName,
        productId: purchaseWrapper.products.first,
      );
      if (isSuccess) {
        _orderRepository.deleteOrder(sku);
        VochatLoadingUtil.dismiss();
        if (_purchaseCallback != null) {
          _purchaseCallback!(true);
        }
        _billingClient?.consumeAsync(purchaseToken);
      } else {
        VochatLoadingUtil.dismiss();
        if (!isFixOrder) {
          VochatLoadingUtil.showToast('vochat_failed'.tr);
        }
        if (_purchaseCallback != null) {
          _purchaseCallback!(false);
        }
      }
    }
  }

  Future<void> fixNoEndPurchase() async {
    if (!VochatAppMacros.enableAnalytics) return;

    BillingResultWrapper billingResultWrapper = await _billingClient!
        .startConnection(onBillingServiceDisconnected: () {});
    if (billingResultWrapper.responseCode == BillingResponse.ok) {
      //获取购买过的 未结束的交易
      PurchasesResultWrapper purchasesResultWrapper =
          await _billingClient!.queryPurchases(ProductType.inapp);
      VochatLogUtil.i(_tag,
          'GoogleBilling fixNoEndPurchase ${purchasesResultWrapper.purchasesList.length}');
      for (var purchaseWrapper in purchasesResultWrapper.purchasesList) {
        //  调用接口获取该交易的状态 成功则结束该交易
        VochatLogUtil.i(_tag, "执行补单操作 ${purchaseWrapper.originalJson}");
        consumeAsync(purchaseWrapper, isFixOrder: true);
      }
    } else {
      VochatLogUtil.i(_tag,
          'GoogleBilling fixNoEndPurchase ${billingResultWrapper.responseCode}');
    }
  }

  void checkPurchaseAndPay(
      VochatProductItemModel product, Function(bool) callBack,
      {VochatOrderItemModel? order}) async {
    if (!VochatAppMacros.enableAnalytics) return;

    VochatLoadingUtil.show();
    BillingResultWrapper billingResultWrapper = await _billingClient!
        .startConnection(onBillingServiceDisconnected: () {});
    if (billingResultWrapper.responseCode == BillingResponse.ok) {
      ProductDetailsResponseWrapper skuDetailsResponseWrapper =
          await _billingClient!.queryProductDetails(productList: [
        ProductWrapper(
            productId: product.productId, productType: ProductType.inapp)
      ]);
      if (skuDetailsResponseWrapper.productDetailsList.isEmpty) {
        callBack(false);
        VochatLoadingUtil.dismiss();
        VochatLoadingUtil.showToast('vochat_invilid_product');
      } else {
        VochatOrderItemModel? orderInfo;
        if (order != null) {
          orderInfo = order;
        } else {
          orderInfo = await _orderRepository.createOrder(product);
        }
        if (orderInfo == null) {
          callBack(false);
          VochatLoadingUtil.dismiss();
          VochatLoadingUtil.showToast('vochat_failed'.tr);
          return;
        }
        _purchaseCallback = callBack;
        ProductDetailsWrapper skuDetailsWrapper =
            skuDetailsResponseWrapper.productDetailsList.first;
        BillingResultWrapper billingResultWrapper =
            await _billingClient!.launchBillingFlow(
          product: skuDetailsWrapper.productId,
          accountId: VochatPreference.userId,
          obfuscatedProfileId: orderInfo.orderNo,
        );
        if (billingResultWrapper.responseCode == BillingResponse.ok) {
          VochatLogUtil.i(_tag, 'GoogleBilling ok');
        } else {
          callBack(false);
          VochatLoadingUtil.dismiss();
          VochatLoadingUtil.showToast(
              billingResultWrapper.debugMessage ?? 'vochat_failed'.tr);
        }
      }
    } else {
      callBack(false);
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast('vochat_failed'.tr);
    }
  }
}
