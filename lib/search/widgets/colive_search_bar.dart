import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../services/static/colive_styles.dart';

class ColiveSearchBar extends StatelessWidget {
  const ColiveSearchBar({
    super.key,
    required this.editingController,
    required this.onSearch,
  });

  final TextEditingController editingController;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ColiveScreenAdapt.appbarSize.width,
      height: ColiveScreenAdapt.appbarSize.height,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              Assets.imagesColiveAppbarBack,
              width: 24.pt,
              height: 24.pt,
            ),
            padding: EdgeInsets.zero,
            iconSize: 44.pt,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColiveColors.cardColor,
                borderRadius: BorderRadius.circular(19.pt),
              ),
              height: 38.pt,
              margin: EdgeInsetsDirectional.only(end: 15.pt),
              padding: EdgeInsetsDirectional.only(
                  start: 10.pt, top: 0.pt, end: 3.pt, bottom: 0.pt),
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Image.asset(
                    Assets.imagesColiveSearchBarIcon,
                    width: 16.pt,
                    height: 16.pt,
                  ),
                  SizedBox(width: 8.pt),
                  Expanded(
                      child: Container(
                    height: 38.pt,
                    alignment: AlignmentDirectional.centerStart,
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) {},
                      onSubmitted: onSearch,
                      cursorColor: ColiveColors.primaryColor,
                      style: ColiveStyles.body14w400,
                      decoration: InputDecoration(
                        hintText: 'colive_search_placeholder'.tr,
                        isDense: true,
                        border: InputBorder.none,
                        counterText: "",
                        contentPadding: EdgeInsets.zero,
                        hintStyle: ColiveStyles.body12w400.copyWith(
                          color: rgba(147, 148, 163, 1),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 8.pt),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.pt),
                      ),
                      height: 32.pt,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 8.pt),
                      child: Text(
                        'colive_search'.tr,
                        style: ColiveStyles.title14w600.copyWith(
                          color: ColiveColors.primaryColor,
                        ),
                      ),
                    ),
                    onTap: () {
                      onSearch(editingController.text);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
