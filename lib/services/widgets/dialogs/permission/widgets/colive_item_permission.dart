import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../static/colive_styles.dart';

class ColiveItemPermission extends StatelessWidget {
  const ColiveItemPermission({
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
              style: ColiveStyles.body14w600,
            ),
            const Spacer(),
            Visibility(
              visible: isGranted,
              replacement: Image.asset(
                Assets.imagesColiveCheckCircle,
                width: 20.pt,
                height: 20.pt,
                color: ColiveColors.primaryColor,
              ),
              child: Image.asset(
                Assets.imagesColiveCheckIn,
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
      return Assets.imagesColivePermissionCamera;
    } else if (permission.value == Permission.photos.value) {
      return Assets.imagesColivePermissionAlbum;
    } else if (permission.value == Permission.microphone.value) {
      return Assets.imagesColivePermissionMicrophone;
    } else if (permission.value == Permission.storage.value) {
      return Assets.imagesColivePermissionStorage;
    } else {
      return "";
    }
  }

  String get _permissionName {
    if (permission.value == Permission.camera.value) {
      return 'colive_camera'.tr;
    } else if (permission.value == Permission.photos.value) {
      return 'colive_photos'.tr;
    } else if (permission.value == Permission.microphone.value) {
      return 'colive_microphone'.tr;
    } else if (permission.value == Permission.storage.value) {
      return 'colive_storage'.tr;
    } else {
      return "";
    }
  }
}
