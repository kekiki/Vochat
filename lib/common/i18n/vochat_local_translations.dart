import 'dart:ui';

import 'package:get/get.dart';
import 'package:vochat/common/i18n/vochat_language_ar.dart';
import 'package:vochat/common/i18n/vochat_language_en.dart';
import 'package:vochat/common/i18n/vochat_language_id.dart';
import 'package:vochat/common/i18n/vochat_language_th.dart';
import 'package:vochat/common/i18n/vochat_language_vi.dart';

import '../../common/preference/vochat_preference.dart';

enum VochatLocalTranslationLanguage {
  // id
  indonesia('Indonesia', 'ID', 'id'),
  // ar
  arabic('عربي', 'SA', 'ar'),
  // th
  thailand('แบบไทย', 'TH', 'th'),
  // vi
  vietnam('Tiếng Việt', 'VN', 'vi'),
  // en
  english('English', 'US', 'en');

  final String name;
  final String country;
  final String code;
  const VochatLocalTranslationLanguage(this.name, this.country, this.code);

  static fromCode(String code) {
    final language = VochatLocalTranslationLanguage.values
        .firstWhereOrNull((element) => element.code == code);
    if (language != null) {
      return language;
    }
    return VochatLocalTranslationLanguage.english;
  }

  static Locale get defaultLocale {
    if (VochatPreference.languageCode.isNotEmpty) {
      return Locale(VochatPreference.languageCode);
    }

    var locale = Get.locale;
    if (locale != null) return locale;

    locale = Get.deviceLocale;
    if (locale != null) {
      final language = VochatLocalTranslationLanguage.values
          .firstWhereOrNull((element) => element.code == locale!.languageCode);
      if (language != null) {
        return Locale(language.code, language.country);
      }
    }
    return const Locale('en', 'US');
  }
}

class VochatLocalTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english,
        'ar': arabic,
        'id': indonesia,
        'th': thailand,
        'vi': vietnam,
      };
}
