import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../services/static/colive_colors.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_settings_controller.dart';
import 'colive_settings_state.dart';

class ColiveSettingsPage extends GetView<ColiveSettingsController> {
  const ColiveSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_settings'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.dataList.length,
              itemBuilder: (context, index) {
                final item = state.dataList[index];
                return _listItemWidget(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemWidget(ColiveSettingItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        height: 60.pt,
        margin: EdgeInsets.symmetric(horizontal: 15.pt),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: ColiveColors.separatorLineColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(item.title.tr, style: ColiveStyles.body14w400),
            const Spacer(),
            Image.asset(
              Assets.imagesColiveMineArrowRight,
              width: 14.pt,
              height: 14.pt,
            ).rtl,
          ],
        ),
      ),
    );
  }
}
