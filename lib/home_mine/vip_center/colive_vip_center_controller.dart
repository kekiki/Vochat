import 'package:easy_refresh/easy_refresh.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/topup/colive_topup_service.dart';
import 'colive_vip_center_state.dart';

class ColiveVipCenterController extends ColiveBaseController {
  final state = ColiveVipCenterState();
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  void onInit() {
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
    _setupProductList();
    super.onInit();

    _fetchProductList();
  }

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      state.profileObs.value = event;
      _fetchProductList();
    }));
  }

  void _setupProductList() {
    final productList = ColiveTopupService.instance.vipProductList;
    state.productListObs.value = productList;
  }

  Future<void> _fetchProductList() async {
    if (state.productListObs.isEmpty) {
      ColiveLoadingUtil.show();
    }
    await ColiveTopupService.instance.fetchVipProductList();
    ColiveLoadingUtil.dismiss();
    _setupProductList();
  }

  void onRefresh() async {
    await _fetchProductList();
    refreshController.finishRefresh(IndicatorResult.success);
  }

  void onTapVIP() {
    final product = state.productListObs[state.selectedProductIndexObs.value];
    ColiveTopupService.instance.purchase(product);
  }
}
