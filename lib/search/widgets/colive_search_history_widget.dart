import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';

class ColiveSearchHistoryWidget extends StatelessWidget {
  const ColiveSearchHistoryWidget({
    super.key,
    required this.historyList,
    required this.onTapSearch,
    required this.onTapClear,
  });

  final List<String> historyList;
  final ValueChanged<String> onTapSearch;
  final VoidCallback onTapClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 15.pt),
            Image.asset(
              Assets.imagesColiveSearchHistoryClock,
              width: 16.pt,
              height: 16.pt,
              color: rgba(147, 148, 163, 1),
            ),
            SizedBox(width: 4.pt),
            Text(
              'colive_history'.tr,
              style: ColiveStyles.body12w400.copyWith(
                color: rgba(147, 148, 163, 1),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onTapClear,
              icon: Image.asset(
                Assets.imagesColiveSearchHistoryDelete,
                width: 16.pt,
                height: 16.pt,
                color: rgba(147, 148, 163, 1),
              ),
              padding: EdgeInsets.zero,
              iconSize: 24.pt,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.pt),
          child: Wrap(
            spacing: 12.pt,
            runSpacing: 12.pt,
            children: historyList
                .map(
                  (e) => _historyItemWidget(e),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _historyItemWidget(String text) {
    return GestureDetector(
      onTap: () => onTapSearch(text),
      child: UnconstrainedBox(
        child: Container(
          height: 30.pt,
          padding: EdgeInsets.symmetric(horizontal: 12.pt),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColiveColors.cardColor,
            borderRadius: BorderRadius.circular(6.pt),
          ),
          child: Text(
            text,
            style: ColiveStyles.body12w400.copyWith(
              color: ColiveColors.secondTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
