import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../common/adapts/vochat_colors.dart';
import '../../../../../common/adapts/vochat_styles.dart';
import '../../../../generated/assets.dart';

class VochatItemPermission extends StatelessWidget {
  const VochatItemPermission({
    super.key,
    required this.permission,
    this.onTap,
    this.isGranted = false,
  });

  final Permission permission;
  final ValueChanged<Permission>? onTap;
  final bool isGranted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(permission),
      child: Container(
        width: 260.pt,
        height: 44.pt,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.pt),
          border: Border.all(color: Colors.grey, width: 1.pt),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(width: 14.pt),
            Image.asset(
              _permissionIcon,
              width: 22.pt,
              height: 22.pt,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8.pt),
            Text(
              _permissionName,
              style: VochatStyles.body14w600,
            ),
            const Spacer(),
            Visibility(
              visible: isGranted,
              replacement: Image.asset(
                Assets.imagesVochatCheckCircle,
                width: 20.pt,
                height: 20.pt,
                color: VochatColors.primaryColor,
              ),
              child: Image.asset(
                Assets.imagesVochatCheckIn,
                width: 20.pt,
                height: 20.pt,
              ),
            ),
            SizedBox(width: 14.pt),
          ],
        ),
      ),
    );
  }

  String get _permissionIcon {
    if (permission.value == Permission.camera.value) {
      return Assets.imagesVochatPermissionCamera;
    } else if (permission.value == Permission.photos.value) {
      return Assets.imagesVochatPermissionAlbum;
    } else if (permission.value == Permission.microphone.value) {
      return Assets.imagesVochatPermissionMicrophone;
    } else if (permission.value == Permission.storage.value) {
      return Assets.imagesVochatPermissionStorage;
    } else {
      return "";
    }
  }

  String get _permissionName {
    if (permission.value == Permission.camera.value) {
      return 'vochat_camera'.tr;
    } else if (permission.value == Permission.photos.value) {
      return 'vochat_photos'.tr;
    } else if (permission.value == Permission.microphone.value) {
      return 'vochat_microphone'.tr;
    } else if (permission.value == Permission.storage.value) {
      return 'vochat_storage'.tr;
    } else {
      return "";
    }
  }
}
