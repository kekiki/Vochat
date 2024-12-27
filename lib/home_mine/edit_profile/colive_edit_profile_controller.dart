import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_keyboard_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import 'package:colive/services/widgets/colive_base_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../services/widgets/dialogs/permission/colive_permission_dialog.dart';
import '../../services/managers/colive_upload_manager.dart';
import '../../services/managers/colive_profile_manager.dart';
import 'colive_edit_nickname_dialog.dart';
import 'colive_edit_profile_state.dart';
import 'colive_edit_signature_dialog.dart';

class ColiveEditProfileController extends ColiveBaseController {
  final state = ColiveEditProfileState();

  final nicknameController = TextEditingController();
  final signatureController = TextEditingController();

  @override
  void onInit() {
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
    super.onInit();
  }

  @override
  void onClose() {
    nicknameController.dispose();
    signatureController.dispose();
    super.onClose();
  }

  @override
  void setupListener() {
    subsriptions.add(
      ColiveProfileManager.instance.profileStream.listen((user) {
        state.profileObs.value = user;
      }),
    );
  }

  void onTapAvatar() async {
    ColiveKeyboardUtil.hideKeyboard(Get.context);

    final status = await Permission.photos.request();
    if (status.isPermanentlyDenied) {
      await Get.dialog(
        const ColivePermissionDialog(
          permissionList: [Permission.photos],
        ),
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    try {
      ColiveLoadingUtil.show();
      final urlList = await ColiveUploadManager.instance
          .uploadFiles(fileList: [imageFile]);
      if (urlList.isNotEmpty) {
        final avatar = urlList.first.toString();
        _updateUserInfo(avatar: avatar);
      } else {
        ColiveLoadingUtil.dismiss();
        ColiveLoadingUtil.showToast('colive_failed'.tr);
      }
    } catch (e) {
      ColiveLogUtil.e('UploadAvatar', e.toString());
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast('colive_failed'.tr);
    }
  }

  void onTapNickname() async {
    nicknameController.text = state.profileObs.value.nickname;
    final confim =
        await ColiveDialogUtil.showDialog(ColiveEditNicknameDialog(
      controller: nicknameController,
    ));
    if (!confim || nicknameController.text.isEmpty) return;
    final nickname = nicknameController.text;
    _updateUserInfo(nickname: nickname);
  }

  void onTapBirthday() {
    final birthday = state.profileObs.value.birthday * 1000;
    final birthdayDate = DateTime.fromMillisecondsSinceEpoch(birthday);
    final now = DateTime.now();
    DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime(now.year - 60, 1, 1),
      maxTime: DateTime(now.year - 18, now.month, now.day),
      currentTime: birthdayDate,
      locale: LocaleType.en,
      theme: DatePickerTheme(
        cancelStyle: ColiveStyles.body14w600,
        doneStyle: ColiveStyles.title16w600.copyWith(
          color: ColiveColors.primaryColor,
        ),
        containerHeight: 260.pt,
        itemHeight: 40.pt,
        itemStyle: ColiveStyles.body16w400,
      ),
      onConfirm: (date) async {
        final birthday = date.millisecondsSinceEpoch ~/ 1000;
        _updateUserInfo(birthday: birthday);
      },
    );
  }

  void onTapSignature() async {
    signatureController.text = state.profileObs.value.signature;
    final confim =
        await ColiveDialogUtil.showDialog(ColiveEditSignatureDialog(
      controller: signatureController,
    ));
    if (!confim || signatureController.text.isEmpty) return;
    final signature = signatureController.text;
    _updateUserInfo(signature: signature);
  }

  Future<void> _updateUserInfo({
    String? avatar,
    String? nickname,
    int? birthday,
    String? signature,
  }) async {
    ColiveLoadingUtil.show();
    final user = state.profileObs.value.copyWith(
      avatar: avatar,
      nickname: nickname,
      birthday: birthday,
      signature: signature,
    );
    final result = await apiClient.editUserInfo(
        user.avatar, user.nickname, '${user.birthday}', user.signature);
    ColiveLoadingUtil.dismiss();
    if (result.isSuccess) {
      ColiveProfileManager.instance.updateLocalInfo(user, true);
      ColiveLoadingUtil.showToast('colive_succeeded'.tr);
    } else {
      ColiveLoadingUtil.showToast(result.msg);
    }
  }
}
