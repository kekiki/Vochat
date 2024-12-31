import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';

import '../../../common/preference/vochat_preference.dart';
import '../../../common/adapts/vochat_colors.dart';
import '../../../common/adapts/vochat_styles.dart';
import '../../generated/assets.dart';
import '../../i18n/vochat_local_translations.dart';

class VochatLanguageDialog extends StatefulWidget {
  const VochatLanguageDialog({super.key});

  @override
  State<VochatLanguageDialog> createState() => _VochatLanguageDialogState();
}

class _VochatLanguageDialogState extends State<VochatLanguageDialog> {
  final List<VochatLocalTranslationLanguage> _dataList = [
    VochatLocalTranslationLanguage.english,
    VochatLocalTranslationLanguage.indonesia,
    VochatLocalTranslationLanguage.arabic,
    VochatLocalTranslationLanguage.thailand,
    VochatLocalTranslationLanguage.vietnam,
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    final code = Get.locale?.languageCode ?? 'en';
    final langguage = VochatLocalTranslationLanguage.fromCode(code);
    _selectedIndex = _dataList.indexOf(langguage);
    super.initState();
  }

  void _onTapConfirm() {
    Get.back();
    final langguage = _dataList[_selectedIndex];
    VochatPreference.languageCode = langguage.code;
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
            "vochat_choose_language".tr,
            style: VochatStyles.title18w700,
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
                color: VochatColors.separatorLineColor,
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
                      border: Border.all(color: VochatColors.primaryColor),
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'vochat_cancel'.tr,
                      style: VochatStyles.title16w700.copyWith(
                        color: VochatColors.primaryColor,
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
                      color: VochatColors.primaryColor,
                      borderRadius: BorderRadius.circular(21.pt),
                    ),
                    child: Text(
                      'vochat_confirm'.tr,
                      style: VochatStyles.title16w700
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
              style: VochatStyles.body16w400.copyWith(
                color: isSelected
                    ? VochatColors.primaryColor
                    : VochatColors.primaryTextColor,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: isSelected,
              replacement: Image.asset(
                Assets.imagesVochatCheckCircle,
                width: 20.pt,
                height: 20.pt,
              ),
              child: Image.asset(
                Assets.imagesVochatCheckIn,
                width: 20.pt,
                height: 20.pt,
                color: VochatColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
