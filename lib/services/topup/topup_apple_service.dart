import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/repositories/colive_order_repository.dart';

import '../models/colive_order_item_model.dart';
import '../models/colive_product_base_model.dart';

class TopupAppleService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  Function(bool succeed)? _purchaseCallback;

  static const _tag = 'AppleTopup';
  final _orderRepository = Get.find<ColiveOrderRepository>();

  /// 单例
  factory TopupAppleService() => _instance;
  static TopupAppleService get instance => _instance;
  static final TopupAppleService _instance = TopupAppleService._();
  TopupAppleService._() {
    listenPurchaseUpdated();
  }

  void listenPurchaseUpdated() {
    _subscription?.cancel();
    _subscription =
        _inAppPurchase.purchaseStream.listen((purchaseDetailsList) async {
      for (var purchaseDetails in purchaseDetailsList) {
        switch (purchaseDetails.status) {
          case PurchaseStatus.pending:
            ColiveLogUtil.i(_tag, '💰 pay Pending...');
            break;
          case PurchaseStatus.purchased:
            ColiveLogUtil.i(_tag, '💰 pay Paid');
            final orderInfo =
                await _orderRepository.queryOrder(purchaseDetails.productID);
            if (orderInfo == null) {
              ColiveLogUtil.i(_tag, '💰 pay order not found');
              await _inAppPurchase.completePurchase(purchaseDetails);
              ColiveLoadingUtil.dismiss();
              if (_purchaseCallback != null) {
                _purchaseCallback!(false);
              }
              break;
            }
            if (purchaseDetails is AppStorePurchaseDetails) {
              final orderId = orderInfo.orderNo;
              final transactionId = purchaseDetails.purchaseID ?? '';
              final receiptData =
                  purchaseDetails.verificationData.serverVerificationData;

              final isSuccess = await _orderRepository.verifyOrderIOS(
                receipt: receiptData,
                orderId: orderId,
                transactionId: transactionId,
              );
              ColiveLoadingUtil.dismiss();
              if (isSuccess) {
                ColiveLogUtil.i(_tag, '💰 pay order did paid');
                await _inAppPurchase.completePurchase(purchaseDetails);
                _orderRepository.deleteOrder(purchaseDetails.productID);
                if (_purchaseCallback != null) {
                  _purchaseCallback!(true);
                }
              } else {
                ColiveLogUtil.i(_tag, '💰 pay order verify failed');
                ColiveLoadingUtil.showToast('colive_failed'.tr);
                if (_purchaseCallback != null) {
                  _purchaseCallback!(false);
                }
              }
            }
            break;
          case PurchaseStatus.error:
            ColiveLogUtil.e(
                _tag, '💰 pay error: ${purchaseDetails.error?.message ?? ''}');
            await _inAppPurchase.completePurchase(purchaseDetails);
            _orderRepository.deleteOrder(purchaseDetails.productID);
            ColiveLoadingUtil.dismiss();
            ColiveLoadingUtil.showToast(
                purchaseDetails.error?.message ?? 'colive_failed'.tr);
            if (_purchaseCallback != null) {
              _purchaseCallback!(false);
            }
            break;
          case PurchaseStatus.restored:
            ColiveLogUtil.i(_tag, '💰 restored succeed');
            await _inAppPurchase.completePurchase(purchaseDetails);
            _orderRepository.deleteOrder(purchaseDetails.productID);
            ColiveLoadingUtil.dismiss();
            if (_purchaseCallback != null) {
              _purchaseCallback!(true);
            }
            break;
          case PurchaseStatus.canceled:
            ColiveLogUtil.i(_tag, '💰 pay canceled');
            await _inAppPurchase.completePurchase(purchaseDetails);
            _orderRepository.deleteOrder(purchaseDetails.productID);
            ColiveLoadingUtil.dismiss();
            ColiveLoadingUtil.showToast('colive_canceled'.tr);
            if (_purchaseCallback != null) {
              _purchaseCallback!(false);
            }
            break;
          default:
            await _inAppPurchase.completePurchase(purchaseDetails);
            _orderRepository.deleteOrder(purchaseDetails.productID);
            ColiveLoadingUtil.dismiss();
            if (_purchaseCallback != null) {
              _purchaseCallback!(false);
            }
            break;
        }
      }
    }, onDone: () {
      if (_purchaseCallback != null) {
        _purchaseCallback!(false);
      }
      ColiveLoadingUtil.dismiss();
      ColiveLogUtil.i(_tag, '💰 pay ondone');
    }, onError: (error) {
      if (_purchaseCallback != null) {
        _purchaseCallback!(false);
      }
      ColiveLoadingUtil.dismiss();
      ColiveLogUtil.e(_tag, '💰 pay error: ${error.toString()}');
    });
  }

  /// 是否有未完成的交易
  Future<void> checkUnCompletePurchases(Function(bool) callBack) async {
    List<SKPaymentTransactionWrapper> notCompleteTransactions =
        <SKPaymentTransactionWrapper>[];

    List<SKPaymentTransactionWrapper> transactions =
        await SKPaymentQueueWrapper().transactions();

    for (SKPaymentTransactionWrapper element in transactions) {
      if (element.transactionState ==
          SKPaymentTransactionStateWrapper.purchased) {
        notCompleteTransactions.add(element);
      } else {
        ColiveLogUtil.i(_tag, '💰 cancel all transactions for payment');
        await SKPaymentQueueWrapper().finishTransaction(element);
      }
    }

    if (notCompleteTransactions.isNotEmpty) {
      callBack.call(true);
      ColiveLoadingUtil.showToast('colive_have_unfinished_order'.tr);
      fixNoEndPurchase();
    }
    callBack.call(false);
  }

  Future<void> fixNoEndPurchase() async {
    final transactions = await SKPaymentQueueWrapper().transactions();
    for (SKPaymentTransactionWrapper element in transactions) {
      if (element.transactionState ==
          SKPaymentTransactionStateWrapper.purchased) {
        ColiveLogUtil.i(_tag, '💰 has pay order did paid no end');

        final sku = element.payment.productIdentifier;
        final orderInfo = await _orderRepository.queryOrder(sku);
        if (orderInfo == null) {
          ColiveLogUtil.i(_tag, '💰 pay order not found');
          SKPaymentQueueWrapper().finishTransaction(element);
          break;
        }

        final orderId = orderInfo.orderNo;
        final transactionId = element.transactionIdentifier ?? '';
        final receiptData = await SKReceiptManager.retrieveReceiptData();

        final isSuccess = await _orderRepository.verifyOrderIOS(
          receipt: receiptData,
          orderId: orderId,
          transactionId: transactionId,
        );
        if (isSuccess) {
          SKPaymentQueueWrapper().finishTransaction(element);
          _orderRepository.deleteOrder(sku);
          ColiveLogUtil.i(_tag, '💰 pay order did paid');
        } else {
          ColiveLogUtil.i(_tag, '💰 pay order verify failed');
        }
      }
    }
  }

  /// 核查苹果内购能否被调起並支付
  void checkPurchaseAndPay(
      ColiveProductItemModel product, Function(bool) callBack,
      {ColiveOrderItemModel? order}) async {
    ColiveLoadingUtil.show();
    checkUnCompletePurchases((hasUnComplete) async {
      if (hasUnComplete == true) {
        ColiveLogUtil.i(_tag, '💰 has pay order no end, cancel this order');
        callBack(false);
        ColiveLoadingUtil.dismiss();
      } else {
        ColiveLogUtil.i(_tag, '💰 start pay');
        final bool available = await _inAppPurchase.isAvailable();
        if (available) {
          ColiveOrderItemModel? orderInfo;
          if (order != null) {
            orderInfo = order;
          } else {
            orderInfo = await _orderRepository.createOrder(product);
          }
          if (orderInfo == null) {
            callBack(false);
            ColiveLoadingUtil.dismiss();
            ColiveLoadingUtil.showToast('colive_failed'.tr);
            return;
          }
          final ProductDetailsResponse result =
              await _inAppPurchase.queryProductDetails({product.productId});
          if (result.productDetails.isNotEmpty) {
            final userId = ColiveAppPreferenceExt.userId;
            final PurchaseParam inAppPurchasePara = PurchaseParam(
                productDetails: result.productDetails.first,
                applicationUserName: '$userId#${orderInfo.orderNo}');
            _purchaseCallback = callBack;
            _inAppPurchase.buyConsumable(purchaseParam: inAppPurchasePara);
          } else {
            callBack(false);
            ColiveLoadingUtil.dismiss();
            if (result.error != null) {
              ColiveLoadingUtil.showToast(
                  result.error?.message ?? result.error.toString());
            } else {
              ColiveLoadingUtil.showToast('colive_invilid_product'.tr);
            }
          }
        } else {
          callBack(false);
          listenPurchaseUpdated();
          ColiveLoadingUtil.dismiss();
          ColiveLoadingUtil.showToast('colive_iap_unsusport'.tr);
        }
      }
    });
  }
}
