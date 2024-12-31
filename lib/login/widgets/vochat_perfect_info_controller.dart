import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/common/utils/vochat_format_util.dart';

import '../../login/managers/vochat_profile_manager.dart';
import '../../common/adapts/vochat_colors.dart';
import '../../common/adapts/vochat_styles.dart';
import '../../common/i18n/vochat_local_translations.dart';
import '../../common/utils/vochat_keyboard_util.dart';
import '../../common/utils/vochat_loading_util.dart';
import '../../common/widgets/dialogs/permission/vochat_permission_dialog.dart';
import '../../common/widgets/vochat_base_controller.dart';

class VochatPerfectInfoController extends VochatBaseController {
  final nicknameController = TextEditingController();

  final avatarPathObs = ''.obs;
  final nicknameTextObs = ''.obs;
  final birthdayTextObs = ''.obs;
  final isGenderMaleObs = false.obs;
  final isEnterButtonEnbaleObs = false.obs;

  @override
  void onClose() {
    nicknameController.removeListener(_nicknameListener);
    nicknameController.dispose();
    super.onClose();
  }

  @override
  void setupListener() {
    nicknameController.addListener(_nicknameListener);
  }

  void _nicknameListener() {
    nicknameTextObs.value = nicknameController.text;
    _resetEnterButtonStatus();
  }

  void _resetEnterButtonStatus() {
    isEnterButtonEnbaleObs.value =
        nicknameTextObs.value.isNotEmpty && birthdayTextObs.value.isNotEmpty;
  }

  void onTapAvatar() async {
    VochatKeyboardUtil.hideKeyboard(Get.context);

    final status = await Permission.photos.request();
    if (status.isPermanentlyDenied) {
      await Get.dialog(
        const VochatPermissionDialog(
          permissionList: [Permission.photos],
        ),
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    avatarPathObs.value = imageFile.path;
  }

  void onTapBirthday() {
    VochatKeyboardUtil.hideKeyboard(Get.context);

    LocaleType localType = LocaleType.en;
    final local = VochatLocalTranslationLanguage.defaultLocale;
    if (local.languageCode == VochatLocalTranslationLanguage.arabic.code) {
      localType = LocaleType.ar;
    } else if (local.languageCode ==
        VochatLocalTranslationLanguage.indonesia.code) {
      localType = LocaleType.id;
    } else if (local.languageCode ==
        VochatLocalTranslationLanguage.thailand.code) {
      localType = LocaleType.th;
    } else if (local.languageCode ==
        VochatLocalTranslationLanguage.vietnam.code) {
      localType = LocaleType.vi;
    }

    final now = DateTime.now();
    final birthdayDate = DateTime(now.year - 20, 1, 1);
    DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime(now.year - 60, 1, 1),
      maxTime: DateTime(now.year - 18, now.month, now.day),
      currentTime: birthdayDate,
      locale: localType,
      theme: DatePickerTheme(
        cancelStyle: VochatStyles.body14w600,
        doneStyle: VochatStyles.title16w600.copyWith(
          color: VochatColors.primaryColor,
        ),
        containerHeight: 260.pt,
        itemHeight: 40.pt,
        itemStyle: VochatStyles.body16w400,
      ),
      onConfirm: (date) async {
        final birthday = date.millisecondsSinceEpoch;
        birthdayTextObs.value = VochatFormatUtil.millisecondsToDate(birthday);
        _resetEnterButtonStatus();
      },
    );
  }

  void onTapGender({required bool isMale}) {
    isGenderMaleObs.value = isMale;
    _resetEnterButtonStatus();
  }

  void onTapEnter() {
    _registerUserInfo();
  }

  Future<void> _registerUserInfo() async {
    try {
      VochatLoadingUtil.show();
      String avatar = '';
      if (avatarPathObs.value.isNotEmpty) {
        final image = XFile(avatarPathObs.value);
        List<int> imageBytes = await image.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        avatar = 'data:image/jpg;base64,$base64Image';
      }
      final gender = isGenderMaleObs.value ? '1' : '2';
      final system = GetPlatform.isIOS ? 'iOS' : 'andorid';

      final result = await apiClient
          .registerUserInfo(
            avatar: avatar,
            nickname: nicknameTextObs.value,
            birthday: birthdayTextObs.value,
            gender: gender,
            system: system,
          )
          .response;
      VochatLoadingUtil.dismiss();
      if (result.isSuccess && result.data != null) {
        VochatProfileManager.instance.login(result.data!);
      } else {
        VochatLoadingUtil.showToast(result.msg);
      }
    } catch (e) {
      VochatLogUtil.e('_registerUserInfo', e.toString());
      VochatLoadingUtil.dismiss();
    }
  }
}
