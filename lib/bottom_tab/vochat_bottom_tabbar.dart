import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../common/adapts/vochat_colors.dart';
import '../common/adapts/vochat_styles.dart';
import '../common/generated/assets.dart';
import 'vochat_bottom_tab_state.dart';

class VochatBottomTabbar extends StatelessWidget {
  const VochatBottomTabbar({
    super.key,
    required this.selectedType,
    required this.onTapTab,
    this.messageCount = 0,
  });

  final int messageCount;
  final VochatBottomTabType selectedType;
  final ValueChanged<VochatBottomTabType> onTapTab;

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
            iconNormal: Assets.imagesVochatTabHomeN,
            iconSelected: Assets.imagesVochatTabHomeS,
            isSelected: selectedType == VochatBottomTabType.home,
            onTap: () => onTapTab(VochatBottomTabType.home),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesVochatTabCommunityN,
            iconSelected: Assets.imagesVochatTabCommunityS,
            isSelected: selectedType == VochatBottomTabType.community,
            onTap: () => onTapTab(VochatBottomTabType.community),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesVochatTabMessageN,
            iconSelected: Assets.imagesVochatTabMessageS,
            isSelected: selectedType == VochatBottomTabType.message,
            count: messageCount,
            onTap: () => onTapTab(VochatBottomTabType.message),
          ),
          _ItemTab(
            title: '',
            iconNormal: Assets.imagesVochatTabMeN,
            iconSelected: Assets.imagesVochatTabMeS,
            isSelected: selectedType == VochatBottomTabType.me,
            onTap: () => onTapTab(VochatBottomTabType.me),
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
      textColor = VochatColors.primaryTextColor;
    } else {
      icon = iconNormal;
      textColor = VochatColors.grayTextColor;
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
                    width: 22.pt,
                  ),
                  Visibility(
                    visible: title.isNotEmpty,
                    child: Text(
                      title,
                      style: VochatStyles.title10w500.copyWith(
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
                        color: VochatColors.accentColor,
                        borderRadius: BorderRadius.circular(8.pt),
                      ),
                      child: Text(
                        unreadText,
                        style: VochatStyles.body10w400.copyWith(
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
