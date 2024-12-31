import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../../common/adapts/vochat_colors.dart';
import '../../common/adapts/vochat_styles.dart';
import '../../common/generated/assets.dart';
import '../../common/widgets/vochat_app_bar.dart';
import '../../common/widgets/vochat_app_scaffold.dart';
import '../../common/widgets/vochat_round_image_widget.dart';
import 'vochat_perfect_info_controller.dart';

class VochatPerfectInfoPage extends GetView<VochatPerfectInfoController> {
  const VochatPerfectInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VochatPerfectInfoController());
    return VochatAppScaffold(
      appBar: VochatAppBar(
        center: Text(
          'vochat_information'.tr,
          style: VochatStyles.title18w700,
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
                _buildAvatarWidget(),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  width: 32.pt,
                  height: 32.pt,
                  child: Image.asset(Assets.imagesVochatIconAvatarAdd),
                ),
              ],
            ),
          ),
          SizedBox(height: 54.pt),
          Container(
            height: 44.pt,
            width: 325.pt,
            decoration: BoxDecoration(
              color: VochatColors.cardColor,
              borderRadius: BorderRadius.circular(22.pt),
            ),
            child: Row(
              children: [
                SizedBox(width: 24.pt),
                Expanded(
                  child: TextField(
                    controller: controller.nicknameController,
                    maxLines: 1,
                    autofocus: true,
                    cursorColor: VochatColors.primaryColor,
                    keyboardType: TextInputType.text,
                    style: VochatStyles.body14w400.copyWith(
                      fontWeight: FontWeight.w600,
                      color: VochatColors.grayTextColor,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'vochat_nickname'.tr,
                      hintStyle: VochatStyles.body14w400.copyWith(
                        color: VochatColors.grayTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 15.pt),
              ],
            ),
          ),
          SizedBox(height: 15.pt),
          GestureDetector(
            onTap: controller.onTapBirthday,
            child: Container(
              height: 44.pt,
              width: 325.pt,
              decoration: BoxDecoration(
                color: VochatColors.cardColor,
                borderRadius: BorderRadius.circular(22.pt),
              ),
              child: Row(
                children: [
                  SizedBox(width: 24.pt),
                  Obx(
                    () => Text(
                      controller.birthdayTextObs.value.isEmpty
                          ? 'vochat_birthday'.tr
                          : controller.birthdayTextObs.value,
                      style: VochatStyles.body14w400.copyWith(
                        color: VochatColors.grayTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Image.asset(Assets.imagesVochatIconCalendar, width: 20.pt),
                  SizedBox(width: 15.pt),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.pt),
          Container(
            height: 44.pt,
            width: 325.pt,
            decoration: BoxDecoration(
              color: VochatColors.cardColor,
              borderRadius: BorderRadius.circular(22.pt),
            ),
            child: Row(
              children: [
                SizedBox(width: 24.pt),
                Text(
                  'vochat_gender'.tr,
                  style: VochatStyles.body14w400.copyWith(
                    color: VochatColors.grayTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => controller.onTapGender(isMale: true),
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.pt, vertical: 4.pt),
                      decoration: BoxDecoration(
                        gradient: controller.isGenderMaleObs.value
                            ? VochatColors.mainGradient
                            : VochatColors.whiteGradient,
                        borderRadius: BorderRadius.circular(15.pt),
                      ),
                      child: Text(
                        'vochat_male'.tr,
                        style: VochatStyles.body14w600.copyWith(
                          color: controller.isGenderMaleObs.value
                              ? Colors.white
                              : VochatColors.grayTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.pt),
                GestureDetector(
                  onTap: () => controller.onTapGender(isMale: false),
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.pt, vertical: 4.pt),
                      decoration: BoxDecoration(
                        gradient: !controller.isGenderMaleObs.value
                            ? VochatColors.mainGradient
                            : VochatColors.whiteGradient,
                        borderRadius: BorderRadius.circular(15.pt),
                      ),
                      child: Text(
                        'vochat_female'.tr,
                        style: VochatStyles.body14w600.copyWith(
                          color: !controller.isGenderMaleObs.value
                              ? Colors.white
                              : VochatColors.grayTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.pt),
              ],
            ),
          ),
          const Spacer(),
          Obx(
            () => Opacity(
              opacity: controller.isEnterButtonEnbaleObs.value ? 1.0 : 0.5,
              child: GestureDetector(
                onTap: controller.onTapEnter,
                child: Container(
                  height: 44.pt,
                  width: 325.pt,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: VochatColors.mainGradient,
                    borderRadius: BorderRadius.circular(22.pt),
                  ),
                  child: Text(
                    'vochat_enter'.tr,
                    style: VochatStyles.title16w700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.pt),
        ],
      ),
    );
  }

  Widget _buildAvatarWidget() {
    return Obx(() {
      final avatarPath = controller.avatarPathObs.value;
      final isLocal = avatarPath.isNotEmpty;
      if (isLocal) {
        return VochatRoundImageWidget(
          avatarPath,
          width: 110.pt,
          height: 110.pt,
          isCircle: true,
          isLocalImage: true,
        );
      }
      return VochatRoundImageWidget(
        controller.isGenderMaleObs.value
            ? Assets.imagesVochatAvatarMale
            : Assets.imagesVochatAvatarFemale,
        width: 110.pt,
        height: 110.pt,
        isCircle: true,
      );
    });
  }
}
