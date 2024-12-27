import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../common/adapts/colive_screen_adapt.dart';
import '../../services/static/colive_styles.dart';
import '../colive_home_state.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    super.key,
    required this.selectedType,
    required this.onTapTab,
    this.messageCount = 0,
  });

  final int messageCount;
  final ColiveHomeTabType selectedType;
  final ValueChanged<ColiveHomeTabType> onTapTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.pt,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesColiveTab1Normal,
            iconSelected: Assets.imagesColiveTab1Selected,
            isSelected: selectedType == ColiveHomeTabType.anchors,
            onTap: () => onTapTab.call(ColiveHomeTabType.anchors),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesColiveTab2Normal,
            iconSelected: Assets.imagesColiveTab2Selected,
            isSelected: selectedType == ColiveHomeTabType.moment,
            onTap: () => onTapTab.call(ColiveHomeTabType.moment),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesColiveTab3Normal,
            iconSelected: Assets.imagesColiveTab3Selected,
            isSelected: selectedType == ColiveHomeTabType.chat,
            count: messageCount,
            onTap: () => onTapTab.call(ColiveHomeTabType.chat),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesColiveTab4Normal,
            iconSelected: Assets.imagesColiveTab4Selected,
            isSelected: selectedType == ColiveHomeTabType.mine,
            onTap: () => onTapTab.call(ColiveHomeTabType.mine),
          ),
        ],
      ),
    );
  }
}

class _ItemTab extends StatelessWidget {
  const _ItemTab({
    required this.title,
    required this.iconNormal,
    required this.iconSelected,
    required this.isSelected,
    this.count = 0,
    this.onTap,
  });

  final String iconNormal;
  final String iconSelected;
  final String title;
  final bool isSelected;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String icon;
    final Color textColor;
    final unreadText = count <= 99 ? count.toString() : "99+";
    if (isSelected) {
      icon = iconSelected;
      textColor = ColiveColors.primaryTextColor;
    } else {
      icon = iconNormal;
      textColor = ColiveColors.grayTextColor;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        width: 75.pt,
        height: 50.pt,
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    width: 32.pt,
                    height: 32.pt,
                    fit: BoxFit.cover,
                  ),
                  Visibility(
                    visible: title.isNotEmpty,
                    child: Text(
                      title,
                      style: ColiveStyles.title10w500.copyWith(
                        color: textColor,
                      ),
                    ).marginOnly(top: 4.pt),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 6.pt,
              start: 0,
              end: 0,
              child: Visibility(
                visible: count > 0,
                child: Row(
                  children: [
                    const Spacer(flex: 5),
                    Container(
                      height: 14.pt,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.pt),
                      decoration: BoxDecoration(
                        color: ColiveColors.accentColor,
                        borderRadius: BorderRadius.circular(8.pt),
                      ),
                      child: Text(
                        unreadText,
                        style: ColiveStyles.body10w400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
