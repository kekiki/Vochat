import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/adapts/vochat_colors.dart';
import '../../../../common/adapts/vochat_styles.dart';
import '../../../../common/widgets/vochat_button_widget.dart';
import '../../../generated/assets.dart';
import 'vochat_permission_controller.dart';
import 'widgets/vochat_item_permission.dart';

class VochatPermissionDialog extends StatelessWidget {
  const VochatPermissionDialog({super.key, required this.permissionList});

  final List<Permission> permissionList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VochatPermissionController>(
      init: VochatPermissionController(),
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
                      style: VochatStyles.title18w700,
                    ),
                    SizedBox(height: 14.pt),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.pt),
                      child: Text(
                        'permission_desc'.tr,
                        style: VochatStyles.body14w400.copyWith(
                          color: VochatColors.primaryTextColor.withOpacity(0.9),
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
                            child: VochatItemPermission(
                              permission: permission,
                              onTap: logic.onTapPermission,
                              isGranted: isGranted,
                            ),
                          );
                        });
                      },
                    ),
                    SizedBox(height: 10.pt),
                    VochatButtonWidget(
                      onPressed: logic.onTapAllowAll,
                      width: 260.pt,
                      height: 44.pt,
                      borderRadius: 22.pt,
                      backgroundColor: VochatColors.buttonNormalColor,
                      child: Text(
                        permissionList.length == 1
                            ? 'vochat_allow'.tr
                            : 'vochat_allow_all'.tr,
                        style: VochatStyles.title16w700.copyWith(
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
                    Assets.imagesVochatDialogClose,
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
