import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/api/colive_api_client.dart';
import 'package:colive/services/topup/widgets/colive_topup_channel_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/managers/colive_socket_manager.dart';
import 'package:colive/services/models/colive_channel_item_model.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/colive_preference_ext.dart';
import '../models/colive_api_response.dart';
import '../models/colive_country_item_model.dart';
import '../models/colive_order_item_model.dart';
import '../models/colive_product_base_model.dart';
import '../repositories/colive_order_repository.dart';
import 'topup_apple_service.dart';
import 'topup_google_service.dart';

class ColiveTopupService {
  ColiveTopupService._internal();

  static ColiveTopupService? _instance;
  static ColiveTopupService get instance =>
      _instance ??= ColiveTopupService._internal();

  static const _tag = "TopupService";
  static const _normal = "1";
  static const _vip = "2";
  static const _promotions = "3";

  final List<ProductDetails> _productDetailsList = [];

  final _apiClient = Get.find<ColiveApiClient>();
  final _orderRepository = Get.find<ColiveOrderRepository>();

  ColiveProductBaseModel _productBaseModel =
      ColiveProductBaseModel.fromJson({});

  List<ColiveProductItemModel> _vipProductList = [];
  List<ColiveProductItemModel> _promotionProductList = [];

  int _promotionRemainSeconds = 0;
  Timer? _promotionTimer;
  final List<ValueChanged<int>> _promotionCountdownActionList = [];

  ColiveProductItemModel? get firstRechargeProduct => _productBaseModel.list
      .firstWhereOrNull((element) => element.isFirstRecharge);
  List<ColiveProductItemModel> get productList => _productBaseModel.list
      .where((element) => !element.isFirstRecharge)
      .toList();
  List<ColiveProductItemModel> get vipProductList => _vipProductList;
  List<ColiveProductItemModel> get promotionProductList =>
      _promotionProductList;
  List<ColiveCountryItemModel> get countryList =>
      _productBaseModel.countryList;
  String get channelCountry => _productBaseModel.channelCountry;

  Future<void> init() async {
    _fixNoEndPurchase();
    await _setupProductDetails();
  }

  Future<void> _setupProductDetails() async {
    final available = await InAppPurchase.instance.isAvailable();
    List<ColiveProductItemModel> tempProductList =
        await _fetchRemoteProduct();
    final identifiers = tempProductList.map((e) => e.productId).toSet();
    if (!available) return;
    final response =
        await InAppPurchase.instance.queryProductDetails(identifiers);
    final errorCode = response.error?.code;
    if (errorCode != null) {
      ColiveLogUtil.e(
          _tag, 'errorCode: $errorCode notFoundIDs: ${response.notFoundIDs}');
    }
    final productDetailList = response.productDetails;
    _productDetailsList.clear();
    _productDetailsList.addAll(productDetailList);
  }

  Future<List<ColiveProductItemModel>> _fetchRemoteProduct() async {
    final List<ColiveProductItemModel> list = [];
    await refreshAllProductList();
    list.addAll(productList);
    list.addAll(vipProductList);
    list.addAll(promotionProductList);
    return list;
  }

  String localPrice(ColiveProductItemModel product) {
    final productDetail = _productDetailsList
        .firstWhereOrNull((element) => element.id == product.productId);
    if (productDetail != null) {
      return productDetail.price;
    }
    return sprintf("${product.currency} %.2f", [product.price]);
  }

  Future<void> refreshAllProductList() async {
    await fetchProductList();
    await fetchVipProductList();
    await fetchPromotionProductList();
  }

  Future<ColiveApiResponse<ColiveProductBaseModel>>
      fetchProductList() async {
    final result = await _apiClient.fetchProductList(_normal).response;
    if (result.isSuccess && result.data != null) {
      _productBaseModel = result.data!;
      if (ColiveAppPreferenceExt.currentTopupCountryCode.isEmpty) {
        ColiveAppPreferenceExt.currentTopupCountryCode =
            _productBaseModel.channelCountry;
      }
    }
    return result;
  }

  Future<ColiveApiResponse<ColiveProductBaseModel>>
      fetchVipProductList() async {
    final result = await _apiClient.fetchProductList(_vip).response;
    if (result.isSuccess && result.data != null) {
      _vipProductList = result.data!.list;
    }
    return result;
  }

  Future<ColiveApiResponse<ColiveProductBaseModel>>
      fetchPromotionProductList() async {
    final result = await _apiClient.fetchProductList(_promotions).response;
    if (result.isSuccess && result.data != null) {
      _promotionProductList = result.data!.list;
      _promotionRemainSeconds = result.data!.countdowns;
      _startPromotionTimer();
    }
    return result;
  }

  void _startPromotionTimer() {
    _cancelPromotionTimer();
    if (_promotionProductList.isEmpty) {
      _promotionRemainSeconds = 0;
      for (var action in _promotionCountdownActionList) {
        action.call(_promotionRemainSeconds);
      }
      return;
    }
    if (_promotionRemainSeconds <= 0) return;
    _promotionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _promotionRemainSeconds--;
      for (var action in _promotionCountdownActionList) {
        action.call(_promotionRemainSeconds);
      }
      if (_promotionRemainSeconds <= 0) {
        _cancelPromotionTimer();
      }
    });
  }

  void _cancelPromotionTimer() {
    _promotionTimer?.cancel();
    _promotionTimer = null;
  }

  void addPromotionCountdownAction(ValueChanged<int>? action) {
    if (action == null) return;
    _promotionCountdownActionList.add(action);
  }

  void removePromotionCountdownAction(ValueChanged<int>? action) {
    if (action == null) return;
    _promotionCountdownActionList.remove(action);
  }

  void _fixNoEndPurchase() async {
    if (GetPlatform.isIOS) {
      TopupAppleService.instance.fixNoEndPurchase();
    } else {
      TopupGoogleService.instance.fixNoEndPurchase();
    }
  }

  Future<ColiveApiResponse<List<ColiveChannelItemModel>>> fetchChannelList(
      {required String productId, required String country}) async {
    return await _apiClient.fetchChannelList(productId, country);
  }

  void purchase(ColiveProductItemModel product) async {
    try {
      ColiveLoadingUtil.show();
      List<ColiveChannelItemModel> channelList = [];
      final currentCountry = ColiveAppPreferenceExt.currentTopupCountryCode;
      if (currentCountry == _productBaseModel.channelCountry &&
          product.channelList.isNotEmpty) {
        channelList = product.channelList;
      } else {
        final result = await fetchChannelList(
            productId: product.id.toString(), country: currentCountry);
        if (result.isSuccess && result.data != null) {
          channelList = result.data ?? [];
        }
      }

      final country = countryList
          .firstWhereOrNull((element) => element.code == currentCountry);
      if (country == null) {
        ColiveLogUtil.e(_tag, 'error: no product channel');
        ColiveLoadingUtil.showToast('colive_failed'.tr);
        return;
      }

      ColiveLoadingUtil.dismiss();
      final ColiveChannelItemModel? channel = await Get.bottomSheet(
        ColiveTopupChannelDialog(
            product: product, channelList: channelList, country: country),
        isScrollControlled: true,
      );
      if (channel == null) return;

      _onOtherPurchase(product, channel);
    } catch (e) {
      ColiveLogUtil.e(_tag, e.toString());
    } finally {
      ColiveLoadingUtil.dismiss();
    }
  }

  void _navivePurchase(
    ColiveProductItemModel product, {
    ColiveOrderItemModel? order,
  }) {
    if (GetPlatform.isIOS) {
      ColiveSocketManager.instance.sendPauseCallMessage(isStop: true);
      TopupAppleService.instance.checkPurchaseAndPay(product, order: order,
          (isSuccess) {
        ColiveSocketManager.instance.sendPauseCallMessage(isStop: false);
        if (isSuccess) {
          ColiveDialogUtil.showDialog(
              ColiveConfirmDialog(content: 'colive_delay_tips'.tr));
          refreshAllProductList();
        }
      });
    } else {
      ColiveSocketManager.instance.sendPauseCallMessage(isStop: true);
      TopupGoogleService.instance.checkPurchaseAndPay(product, order: order,
          (isSuccess) {
        ColiveSocketManager.instance.sendPauseCallMessage(isStop: false);
        if (isSuccess) {
          ColiveDialogUtil.showDialog(
              ColiveConfirmDialog(content: 'colive_delay_tips'.tr));
          refreshAllProductList();
        }
      });
    }
  }

  void _onOtherPurchase(
      ColiveProductItemModel product, ColiveChannelItemModel channel) {
    ColiveLoadingUtil.show();
    _orderRepository
        .createOrder(product, channelId: '${channel.channelId}')
        .then((orderInfo) {
      ColiveLoadingUtil.dismiss();
      if (orderInfo == null) {
        ColiveLoadingUtil.showToast('colive_failed'.tr);
        return;
      }
      if (orderInfo.isNative) {
        _navivePurchase(product, order: orderInfo);
      } else {
        launchUrl(Uri.parse(orderInfo.url),
            mode: LaunchMode.externalApplication);
      }
    }).catchError((e) {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast(e.toString());
    });
  }
}
