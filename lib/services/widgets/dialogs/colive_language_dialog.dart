import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../extensions/colive_preference_ext.dart';
import '../../i18n/colive_local_translations.dart';
import '../../static/colive_colors.dart';
import '../../static/colive_styles.dart';

class ColiveLanguageDialog extends StatefulWidget {
  const ColiveLanguageDialog({super.key});

  @override
  State<ColiveLanguageDialog> createState() => _ColiveLanguageDialogState();
}

class _ColiveLanguageDialogState extends State<ColiveLanguageDialog> {
  final List<ColiveLocalTranslationLanguage> _dataList = [
    ColiveLocalTranslationLanguage.english,
    ColiveLocalTranslationLanguage.indonesia,
    ColiveLocalTranslationLanguage.arabic,
    ColiveLocalTranslationLanguage.thailand,
    ColiveLocalTranslationLanguage.vietnam,
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    final code = Get.locale?.languageCode ?? 'en';
    final langguage = ColiveLocalTranslationLanguage.fromCode(code);
    _selectedIndex = _dataList.indexOf(langguage);
    super.initState();
  }

  void _onTapConfirm() {
    Get.back();
    final langguage = _dataList[_selectedIndex];
    ColiveAppPreferenceExt.languageCode = langguage.code;
    Get.updateLocale(Locale(langguage.code));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.pt),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.pt, horizontal: 18.pt),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "colive_choose_language".tr,
            style: ColiveStyles.title18w700,
          ),
          SizedBox(height: 10.pt),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => _languageItemWidget(index),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0.5,
                indent: 0,
                endIndent: 0,
                color: ColiveColors.separatorLineColor,
              );
            },
            itemCount: _dataList.length,
          ),
          SizedBox(height: 14.pt),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: Get.back,
                  child: Container(
                    height: 42.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColiveColors.primaryColor),
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_cancel'.tr,
                      style: ColiveStyles.title16w700.copyWith(
                        color: ColiveColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.pt),
              Expanded(
                child: GestureDetector(
                  onTap: _onTapConfirm,
                  child: Container(
                    height: 42.pt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColiveColors.primaryColor,
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'colive_confirm'.tr,
                      style: ColiveStyles.title16w700
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _languageItemWidget(int index) {
    final isSelected = _selectedIndex == index;
    final language = _dataList[index];
    return GestureDetector(
      onTap: () {
        _selectedIndex = index;
        setState(() {});
      },
      child: Container(
        width: 345.pt,
        height: 50.pt,
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              language.name,
              style: ColiveStyles.body16w400.copyWith(
                color: isSelected
                    ? ColiveColors.primaryColor
                    : ColiveColors.primaryTextColor,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: isSelected,
              replacement: Image.asset(
                Assets.imagesColiveCheckCircle,
                width: 20.pt,
                height: 20.pt,
              ),
              child: Image.asset(
                Assets.imagesColiveCheckIn,
                width: 20.pt,
                height: 20.pt,
                color: ColiveColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
