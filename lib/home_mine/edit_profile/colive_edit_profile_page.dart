import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:colive/services/widgets/colive_app_scaffold.dart';

import '../../services/widgets/colive_app_bar.dart';
import 'colive_edit_profile_controller.dart';
import 'colive_edit_profile_state.dart';

class ColiveEditProfilePage extends GetView<ColiveEditProfileController> {
  const ColiveEditProfilePage({super.key});

  ColiveEditProfileState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_edit_profile'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 42.pt),
          InkWell(
            borderRadius: BorderRadius.circular(60.pt),
            onTap: controller.onTapAvatar,
            child: Stack(
              children: [
                Obx(
                  () => ColiveRoundImageWidget(
                    state.profileObs.value.avatar,
                    width: 120.pt,
                    height: 120.pt,
                    isCircle: true,
                    placeholder: Assets.imagesColiveAvatarUser,
                  ),
                ),
                PositionedDirectional(
                  bottom: 2.pt,
                  end: 2.pt,
                  width: 28.pt,
                  height: 28.pt,
                  child: Image.asset(Assets.imagesColiveProdileEditAvatar),
                ),
              ],
            ),
          ),
          SizedBox(height: 80.pt),
          Obx(() {
            return InkWell(
              onTap: controller.onTapNickname,
              child: _infoItemWidget(
                title: 'colive_nickname'.tr,
                desc: state.profileObs.value.nickname,
              ),
            );
          }),
          Obx(() {
            return _infoItemWidget(
              title: 'colive_id'.tr,
              desc: state.profileObs.value.id.toString(),
              showArrow: false,
            );
          }),
          Obx(() {
            final birthday = ColiveFormatUtil.millisecondsToDate(
                state.profileObs.value.birthday * 1000);
            return InkWell(
              onTap: controller.onTapBirthday,
              child: _infoItemWidget(
                title: 'colive_birthday'.tr,
                desc: birthday,
              ),
            );
          }),
          Obx(() {
            return InkWell(
              onTap: controller.onTapSignature,
              child: _infoItemWidget(
                title: 'colive_signature'.tr,
                desc: state.profileObs.value.signature,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _infoItemWidget({
    required String title,
    required String desc,
    bool showArrow = true,
  }) {
    return Container(
      height: 56.pt,
      margin: EdgeInsets.symmetric(horizontal: 14.pt),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColiveColors.separatorLineColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(title, style: ColiveStyles.body14w400),
          SizedBox(width: 60.pt),
          Expanded(
            child: Text(
              desc,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ColiveStyles.body14w400.copyWith(
                color: ColiveColors.grayTextColor,
              ),
            ),
          ),
          Visibility(
            visible: showArrow,
            child: Image.asset(
              Assets.imagesColiveMineArrowRight,
              width: 16.pt,
              height: 16.pt,
              color: ColiveColors.grayTextColor,
            ).rtl,
          ),
        ],
      ),
    );
  }
}
