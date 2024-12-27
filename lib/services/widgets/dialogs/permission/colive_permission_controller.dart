import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import 'colive_permission_state.dart';

class ColivePermissionController extends GetxController {
  final state = ColivePermissionState();

  void setPermissionList(List<Permission> permissionList) async {
    state.permissionList = permissionList;
    for (int i = 0; i < permissionList.length; i++) {
      final permission = permissionList[i];
      state.grantListObs[i] = await permission.isGranted;
    }
  }

  void onTapPermission(Permission permission) async {
    final isGranted = await permission.request().isGranted;
    final index = state.permissionList.indexOf(permission);
    if (index == -1) return;
    state.grantListObs[index] = isGranted;
    final isPermanentlyDenied = await permission.request().isPermanentlyDenied;
    if (isPermanentlyDenied) {
      OpenSettings.openAppSetting();
    }
    _checkIfNeedBack();
  }

  void onTapAllowAll() async {
    for (int i = 0; i < state.permissionList.length; i++) {
      final permission = state.permissionList[i];
      final isGrant = await permission.request().isGranted;
      final isPermanentlyDenied =
          await permission.request().isPermanentlyDenied;
      if (isPermanentlyDenied) {
        OpenSettings.openAppSetting();
      }
      state.grantListObs[i] = isGrant;
    }
    _checkIfNeedBack();
  }

  void _checkIfNeedBack() {
    final isAllGrant =
        state.grantListObs.where((isGrant) => isGrant == false).isEmpty;
    if (isAllGrant) {
      Get.back();
    }
  }
}
