import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ColivePermissionState {
  final List<Permission> _permissionList = [];

  final grantListObs = RxList<bool>();

  List<Permission> get permissionList => _permissionList;

  set permissionList(List<Permission> list) {
    _permissionList.clear();
    _permissionList.addAll(list);
    grantListObs.addAll(list.map((e) => false));
  }
}
