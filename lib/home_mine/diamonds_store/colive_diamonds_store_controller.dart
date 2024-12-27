import 'package:easy_refresh/easy_refresh.dart';
import 'package:colive/services/topup/colive_topup_service.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_product_base_model.dart';
import 'colive_diamonds_store_state.dart';

class ColiveDiamondsStoreController extends ColiveBaseController {
  final state = ColiveDiamondsStoreState();
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  void onInit() {
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
    state.firstRechargeProduct.value =
        ColiveTopupService.instance.firstRechargeProduct;
    state.productListObs.value = ColiveTopupService.instance.productList;
    super.onInit();

    ColiveTopupService.instance
        .addPromotionCountdownAction(_firstRechargeCountdown);
  }

  @override
  void onClose() {
    ColiveTopupService.instance
        .removePromotionCountdownAction(_firstRechargeCountdown);
    super.onClose();
  }

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      state.profileObs.value = event;
      onRefresh();
    }));
  }

  void _firstRechargeCountdown(int seconds) {
    state.countdownObs.value = seconds;
  }

  void onRefresh() async {
    final result = await ColiveTopupService.instance.fetchProductList();
    if (result.isSuccess) {
      state.firstRechargeProduct.value =
          ColiveTopupService.instance.firstRechargeProduct;
      state.productListObs.value = ColiveTopupService.instance.productList;
    }
    refreshController.finishRefresh(
      result.isSuccess ? IndicatorResult.success : IndicatorResult.fail,
    );
  }

  void onTapProduct(ColiveProductItemModel product) {
    ColiveTopupService.instance.purchase(product);
  }
}
