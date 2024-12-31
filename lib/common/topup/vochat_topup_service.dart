import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/services/managers/vochat_socket_manager.dart';
import 'package:vochat/services/models/vochat_channel_item_model.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/api/vochat_api_client.dart';
import '../../common/preference/vochat_preference.dart';
import '../../common/widgets/dialogs/vochat_confirm_dialog.dart';
import '../../common/widgets/dialogs/vochat_dialog_util.dart';
import '../../services/models/vochat_api_response.dart';
import '../../services/models/vochat_country_item_model.dart';
import '../../services/models/vochat_order_item_model.dart';
import '../../services/models/vochat_product_base_model.dart';
import '../../services/repositories/vochat_order_repository.dart';
import 'topup_apple_service.dart';
import 'topup_google_service.dart';
import 'widgets/vochat_topup_channel_dialog.dart';

class VochatTopupService {
  VochatTopupService._internal();

  static VochatTopupService? _instance;
  static VochatTopupService get instance =>
      _instance ??= VochatTopupService._internal();

  static const _tag = "TopupService";
  static const _normal = "1";
  static const _vip = "2";
  static const _promotions = "3";

  final List<ProductDetails> _productDetailsList = [];

  final _apiClient = Get.find<VochatApiClient>();
  final _orderRepository = Get.find<VochatOrderRepository>();

  VochatProductBaseModel _productBaseModel =
      VochatProductBaseModel.fromJson({});

  List<VochatProductItemModel> _vipProductList = [];
  List<VochatProductItemModel> _promotionProductList = [];

  int _promotionRemainSeconds = 0;
  Timer? _promotionTimer;
  final List<ValueChanged<int>> _promotionCountdownActionList = [];

  VochatProductItemModel? get firstRechargeProduct => _productBaseModel.list
      .firstWhereOrNull((element) => element.isFirstRecharge);
  List<VochatProductItemModel> get productList => _productBaseModel.list
      .where((element) => !element.isFirstRecharge)
      .toList();
  List<VochatProductItemModel> get vipProductList => _vipProductList;
  List<VochatProductItemModel> get promotionProductList =>
      _promotionProductList;
  List<VochatCountryItemModel> get countryList => _productBaseModel.countryList;
  String get channelCountry => _productBaseModel.channelCountry;

  Future<void> init() async {
    _fixNoEndPurchase();
    await _setupProductDetails();
  }

  Future<void> _setupProductDetails() async {
    final available = await InAppPurchase.instance.isAvailable();
    List<VochatProductItemModel> tempProductList = await _fetchRemoteProduct();
    final identifiers = tempProductList.map((e) => e.productId).toSet();
    if (!available) return;
    final response =
        await InAppPurchase.instance.queryProductDetails(identifiers);
    final errorCode = response.error?.code;
    if (errorCode != null) {
      VochatLogUtil.e(
          _tag, 'errorCode: $errorCode notFoundIDs: ${response.notFoundIDs}');
    }
    final productDetailList = response.productDetails;
    _productDetailsList.clear();
    _productDetailsList.addAll(productDetailList);
  }

  Future<List<VochatProductItemModel>> _fetchRemoteProduct() async {
    final List<VochatProductItemModel> list = [];
    await refreshAllProductList();
    list.addAll(productList);
    list.addAll(vipProductList);
    list.addAll(promotionProductList);
    return list;
  }

  String localPrice(VochatProductItemModel product) {
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

  Future<VochatApiResponse<VochatProductBaseModel>> fetchProductList() async {
    final result = await _apiClient.fetchProductList(_normal).response;
    if (result.isSuccess && result.data != null) {
      _productBaseModel = result.data!;
      if (VochatPreference.currentTopupCountryCode.isEmpty) {
        VochatPreference.currentTopupCountryCode =
            _productBaseModel.channelCountry;
      }
    }
    return result;
  }

  Future<VochatApiResponse<VochatProductBaseModel>>
      fetchVipProductList() async {
    final result = await _apiClient.fetchProductList(_vip).response;
    if (result.isSuccess && result.data != null) {
      _vipProductList = result.data!.list;
    }
    return result;
  }

  Future<VochatApiResponse<VochatProductBaseModel>>
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

  Future<VochatApiResponse<List<VochatChannelItemModel>>> fetchChannelList(
      {required String productId, required String country}) async {
    return await _apiClient.fetchChannelList(productId, country);
  }

  void purchase(VochatProductItemModel product) async {
    try {
      VochatLoadingUtil.show();
      List<VochatChannelItemModel> channelList = [];
      final currentCountry = VochatPreference.currentTopupCountryCode;
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
        VochatLogUtil.e(_tag, 'error: no product channel');
        VochatLoadingUtil.showToast('vochat_failed'.tr);
        return;
      }

      VochatLoadingUtil.dismiss();
      final VochatChannelItemModel? channel = await Get.bottomSheet(
        VochatTopupChannelDialog(
            product: product, channelList: channelList, country: country),
        isScrollControlled: true,
      );
      if (channel == null) return;

      _onOtherPurchase(product, channel);
    } catch (e) {
      VochatLogUtil.e(_tag, e.toString());
    } finally {
      VochatLoadingUtil.dismiss();
    }
  }

  void _navivePurchase(
    VochatProductItemModel product, {
    VochatOrderItemModel? order,
  }) {
    if (GetPlatform.isIOS) {
      VochatSocketManager.instance.sendPauseCallMessage(isStop: true);
      TopupAppleService.instance.checkPurchaseAndPay(product, order: order,
          (isSuccess) {
        VochatSocketManager.instance.sendPauseCallMessage(isStop: false);
        if (isSuccess) {
          VochatDialogUtil.showDialog(
              VochatConfirmDialog(content: 'vochat_delay_tips'.tr));
          refreshAllProductList();
        }
      });
    } else {
      VochatSocketManager.instance.sendPauseCallMessage(isStop: true);
      TopupGoogleService.instance.checkPurchaseAndPay(product, order: order,
          (isSuccess) {
        VochatSocketManager.instance.sendPauseCallMessage(isStop: false);
        if (isSuccess) {
          VochatDialogUtil.showDialog(
              VochatConfirmDialog(content: 'vochat_delay_tips'.tr));
          refreshAllProductList();
        }
      });
    }
  }

  void _onOtherPurchase(
      VochatProductItemModel product, VochatChannelItemModel channel) {
    VochatLoadingUtil.show();
    _orderRepository
        .createOrder(product, channelId: '${channel.channelId}')
        .then((orderInfo) {
      VochatLoadingUtil.dismiss();
      if (orderInfo == null) {
        VochatLoadingUtil.showToast('vochat_failed'.tr);
        return;
      }
      if (orderInfo.isNative) {
        _navivePurchase(product, order: orderInfo);
      } else {
        launchUrl(Uri.parse(orderInfo.url),
            mode: LaunchMode.externalApplication);
      }
    }).catchError((e) {
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast(e.toString());
    });
  }
}
