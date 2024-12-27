import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colive/common/event_bus/colive_event_bus.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/managers/colive_upload_manager.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/utils/colive_keyboard_util.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/widgets/dialogs/permission/colive_permission_dialog.dart';
import 'colive_moment_post_state.dart';

class ColiveMomentPostController extends ColiveBaseController {
  final state = ColiveMomentPostState();
  final editingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    editingController.addListener(_resetButtonStatus);
  }

  @override
  void onClose() {
    editingController.removeListener(_resetButtonStatus);
    editingController.dispose();
    super.onClose();
  }

  void onTapAddImage() async {
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
    final limit = state.maxImageCount - state.imageFileListObs.length;
    if (limit > 1) {
      final fileList = await picker.pickMultiImage(limit: limit);
      state.imageFileListObs.addAll(fileList);
    } else {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file == null) return;
      state.imageFileListObs.add(file);
    }
    _resetButtonStatus();
  }

  void onTapDeleteImage(int index) {
    state.imageFileListObs.removeAt(index);
    _resetButtonStatus();
  }

  void _resetButtonStatus() {
    state.isButtonEnableObs.value =
        editingController.text.isNotEmpty && state.imageFileListObs.isNotEmpty;
  }

  void onTapPost() async {
    if (!state.isButtonEnableObs.value) return;
    final content = editingController.text;
    try {
      ColiveLoadingUtil.show();
      final images = await ColiveUploadManager.instance
          .uploadFiles(fileList: state.imageFileListObs);
      if (images.isEmpty) {
        ColiveLoadingUtil.dismiss();
        ColiveLoadingUtil.showError('colive_failed'.tr);
        return;
      }

      final result = await apiClient.createMoment(content, images);
      ColiveLoadingUtil.dismiss();
      if (result.isSuccess) {
        ColiveLoadingUtil.showSuccess('colive_succeeded'.tr);
        ColiveEventBus.instance.fire(ColiveMomentPostSucceedEvent());
        Get.back();
      } else {
        ColiveLoadingUtil.showError(result.msg);
      }
    } catch (e) {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showError('colive_failed'.tr);
      ColiveLogUtil.e('MomentPost', 'post errer: ${e.toString()}');
    }
  }
}
