import 'package:get/get.dart';

import '../../services/models/colive_login_model.dart';
import '../../services/models/colive_product_base_model.dart';

class ColiveDiamondsStoreState {
  final firstRechargeProduct = Rxn<ColiveProductItemModel>();
  final productListObs = <ColiveProductItemModel>[].obs;
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
  final countdownObs = 0.obs;
}
