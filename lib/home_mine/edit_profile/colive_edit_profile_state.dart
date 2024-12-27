import 'package:get/get.dart';

import '../../services/models/colive_login_model.dart';

class ColiveEditProfileState {
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
}
