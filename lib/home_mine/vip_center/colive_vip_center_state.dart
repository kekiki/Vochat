import 'dart:ui';

import 'package:get/get.dart';
import 'package:colive/generated/assets.dart';

import '../../services/models/colive_login_model.dart';
import '../../services/models/colive_product_base_model.dart';
import '../../services/static/colive_colors.dart';

class ColiveVipPrivilegeModel {
  final String icon;
  final String title;
  final String desc;
  final List<Color> colors;

  ColiveVipPrivilegeModel({
    required this.icon,
    required this.title,
    required this.desc,
    required this.colors,
  });
}

class ColiveVipCenterState {
  final privilegeList = [
    ColiveVipPrivilegeModel(
      icon: Assets.imagesColiveVipPrivilegeCall,
      title: 'colive_privilege_call_text'.tr,
      desc: 'colive_privilege_call_desc'.tr,
      colors: [rgba(234, 8, 191, 1), rgba(255, 126, 70, 1)],
    ),
    ColiveVipPrivilegeModel(
      icon: Assets.imagesColiveVipPrivilegeVideo,
      title: 'colive_privilege_video_text'.tr,
      desc: 'colive_privilege_video_desc'.tr,
      colors: [rgba(121, 60, 249, 1), rgba(255, 80, 101, 1)],
    ),
    ColiveVipPrivilegeModel(
      icon: Assets.imagesColiveVipPrivilegeChat,
      title: 'colive_privilege_chat_text'.tr,
      desc: 'colive_privilege_chat_desc'.tr,
      colors: [rgba(246, 94, 195, 1), rgba(240, 51, 142, 1)],
    ),
    ColiveVipPrivilegeModel(
      icon: Assets.imagesColiveVipPrivilegeDiamond,
      title: 'colive_privilege_diamond_text'.tr,
      desc: 'colive_privilege_diamond_desc'.tr,
      colors: [rgba(121, 75, 253, 1), rgba(36, 97, 255, 1)],
    ),
    ColiveVipPrivilegeModel(
      icon: Assets.imagesColiveVipPrivilegePhoto,
      title: 'colive_privilege_photo_text'.tr,
      desc: 'colive_privilege_photo_desc'.tr,
      colors: [rgba(170, 60, 237, 1), rgba(112, 49, 245, 1)],
    ),
  ];
  final currentPrivilegeIndexObs = 0.obs;

  final productListObs = <ColiveProductItemModel>[].obs;
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
  final selectedProductIndexObs = 0.obs;
}
