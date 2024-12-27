import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../services/models/colive_card_base_model.dart';
import '../services/models/colive_login_model.dart';

class ColiveMineListItem {
  final String icon;
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;
  ColiveMineListItem({
    required this.icon,
    required this.title,
    this.subTitle,
    this.onTap,
  });
}

class ColiveHomeMineState {
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
  final isNoDisturbModeObs = false.obs;
  final dataListObs = <ColiveMineListItem>[].obs;
  List<ColiveCardItemModel> cardList = [];

  final lottreyEndObs = 6.pt.obs;
  final lottreyBottomObs = 60.pt.obs;
}
