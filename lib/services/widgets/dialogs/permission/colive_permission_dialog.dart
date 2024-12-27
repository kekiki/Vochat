import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/widgets/colive_button_widget.dart';
import '../../../static/colive_colors.dart';
import 'colive_permission_controller.dart';
import 'widgets/colive_item_permission.dart';

class ColivePermissionDialog extends StatelessWidget {
  const ColivePermissionDialog({super.key, required this.permissionList});

  final List<Permission> permissionList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColivePermissionController>(
      init: ColivePermissionController(),
      autoRemove: true,
      assignId: true,
      builder: (logic) {
        final state = logic.state;
        logic.setPermissionList(permissionList);
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 30.pt),
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.pt),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.pt),
                    Text(
                      'permission_tips'.tr,
                      style: ColiveStyles.title18w700,
                    ),
                    SizedBox(height: 14.pt),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.pt),
                      child: Text(
                        'permission_desc'.tr,
                        style: ColiveStyles.body14w400.copyWith(
                          color:
                              ColiveColors.primaryTextColor.withOpacity(0.9),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.pt),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: permissionList.length,
                      itemBuilder: (context, index) {
                        final permission = permissionList[index];
                        return Obx(() {
                          final isGranted = state.grantListObs[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27.pt,
                              vertical: 6.pt,
                            ),
                            child: ColiveItemPermission(
                              permission: permission,
                              onTap: logic.onTapPermission,
                              isGranted: isGranted,
                            ),
                          );
                        });
                      },
                    ),
                    SizedBox(height: 10.pt),
                    ColiveButtonWidget(
                      onPressed: logic.onTapAllowAll,
                      width: 260.pt,
                      height: 44.pt,
                      borderRadius: 22.pt,
                      backgroundColor: ColiveColors.buttonNormalColor,
                      child: Text(
                        permissionList.length == 1
                            ? 'colive_allow'.tr
                            : 'colive_allow_all'.tr,
                        style: ColiveStyles.title16w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.pt),
                  ],
                ),
              ),
              SizedBox(height: 24.pt),
              SizedBox(
                width: 32.pt,
                height: 32.pt,
                child: IconButton(
                  onPressed: Get.back,
                  iconSize: 32.pt,
                  padding: EdgeInsets.zero,
                  splashRadius: 20.pt,
                  icon: Image.asset(
                    Assets.imagesColiveDialogClose,
                    width: 32.pt,
                    height: 32.pt,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 24.pt),
            ],
          ),
        );
      },
    );
  }
}
