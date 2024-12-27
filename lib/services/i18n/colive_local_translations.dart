import 'dart:ui';

import 'package:get/get.dart';
import 'package:colive/services/i18n/colive_language_ar.dart';
import 'package:colive/services/i18n/colive_language_en.dart';
import 'package:colive/services/i18n/colive_language_id.dart';
import 'package:colive/services/i18n/colive_language_th.dart';
import 'package:colive/services/i18n/colive_language_vi.dart';

import '../extensions/colive_preference_ext.dart';

enum ColiveLocalTranslationLanguage {
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
  const ColiveLocalTranslationLanguage(this.name, this.country, this.code);

  static fromCode(String code) {
    final language = ColiveLocalTranslationLanguage.values
        .firstWhereOrNull((element) => element.code == code);
    if (language != null) {
      return language;
    }
    return ColiveLocalTranslationLanguage.english;
  }

  static Locale get defaultLocale {
    if (ColiveAppPreferenceExt.languageCode.isNotEmpty) {
      return Locale(ColiveAppPreferenceExt.languageCode);
    }

    var locale = Get.locale;
    if (locale != null) return locale;

    locale = Get.deviceLocale;
    if (locale != null) {
      final language = ColiveLocalTranslationLanguage.values
          .firstWhereOrNull((element) => element.code == locale!.languageCode);
      if (language != null) {
        return Locale(language.code, language.country);
      }
    }
    return const Locale('en', 'US');
  }
}

class ColiveLocalTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english,
        'ar': arabic,
        'id': indonesia,
        'th': thailand,
        'vi': vietnam,
      };
}
