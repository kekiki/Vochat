import 'dart:convert';

import '../../common/preference/colive_preference.dart';

extension ColiveAppPreferenceExt on ColiveAppPreference {
  // Production Mode
  static bool get isProductionMode =>
      ColiveAppPreference.box.get('isProductionMode', defaultValue: true);

  static set isProductionMode(bool value) =>
      ColiveAppPreference.box.put('isProductionMode', value);

  // accept privacy policy and terms of use
  static bool get acceptPrivacyPolicy =>
      ColiveAppPreference.box.get('acceptPrivacyPolicy', defaultValue: false);

  static set acceptPrivacyPolicy(bool value) =>
      ColiveAppPreference.box.put('acceptPrivacyPolicy', value);

  // language code
  static String get languageCode =>
      ColiveAppPreference.box.get('languageCode', defaultValue: '');

  static set languageCode(String value) =>
      ColiveAppPreference.box.put('languageCode', value);

  // appsflyer
  static set afid(String afid) => ColiveAppPreference.box.put('afid', afid);

  static String get afid =>
      ColiveAppPreference.box.get('afid', defaultValue: '');

  static set afNetwork(String network) =>
      ColiveAppPreference.box.put('afNetwork', network);

  static String get afNetwork =>
      ColiveAppPreference.box.get('afNetwork', defaultValue: '');

  // iOS idfa
  static set adid(String network) =>
      ColiveAppPreference.box.put('adid', network);

  static String get adid =>
      ColiveAppPreference.box.get('adid', defaultValue: '');

  // dt id
  static set dtId(String dtId) => ColiveAppPreference.box.put('dtId', dtId);

  static String get dtId =>
      ColiveAppPreference.box.get('dtId', defaultValue: '');

  // referrer
  static set installReferrer(String referrer) =>
      ColiveAppPreference.box.put('installReferrer', referrer);

  static String get installReferrer =>
      ColiveAppPreference.box.get('installReferrer', defaultValue: '');

  // api token
  static set apiToken(String value) =>
      ColiveAppPreference.box.put('apiToken', value);

  static String get apiToken =>
      ColiveAppPreference.box.get('apiToken', defaultValue: '');

  // user id
  static String get userId =>
      ColiveAppPreference.box.get('userId', defaultValue: '');

  static set userId(String value) =>
      ColiveAppPreference.box.put('userId', value);

  // user info
  static set userInfoJson(Map<String, dynamic> value) =>
      ColiveAppPreference.box.put('userInfoJson', jsonEncode(value));

  static Map<String, dynamic> get userInfoJson => jsonDecode(
      ColiveAppPreference.box.get('userInfoJson', defaultValue: '{}'));

  // customer service id
  static String get customerServiceId =>
      ColiveAppPreference.box.get('customerServiceId', defaultValue: '');

  static set customerServiceId(String value) =>
      ColiveAppPreference.box.put('customerServiceId', value);

  // current area
  static String get currentArea =>
      ColiveAppPreference.box.get('currentArea', defaultValue: '');

  static set currentArea(String value) =>
      ColiveAppPreference.box.put('currentArea', value);

  // area list
  static set areList(List value) =>
      ColiveAppPreference.box.put('areList', jsonEncode(value));

  static List get areList =>
      jsonDecode(ColiveAppPreference.box.get('areList', defaultValue: []));

  // No Disturb Mode
  static bool get isNoDisturbMode =>
      ColiveAppPreference.box.get('isNoDisturbMode', defaultValue: false);

  static set isNoDisturbMode(bool value) =>
      ColiveAppPreference.box.put('isNoDisturbMode', value);

  // gift info
  static set giftInfoJson(Map<String, dynamic> value) =>
      ColiveAppPreference.box.put('giftInfoJson', jsonEncode(value));

  static Map<String, dynamic> get giftInfoJson => jsonDecode(
      ColiveAppPreference.box.get('giftInfoJson', defaultValue: '{}'));

  // lucky draw
  static set luckyDrawJson(Map<String, dynamic> value) =>
      ColiveAppPreference.box.put('luckyDrawJson', jsonEncode(value));

  static Map<String, dynamic> get luckyDrawJson => jsonDecode(
      ColiveAppPreference.box.get('luckyDrawJson', defaultValue: '{}'));

  // current topup country
  static String get currentTopupCountryCode =>
      ColiveAppPreference.box.get('currentTopupCountryCode', defaultValue: '');

  static set currentTopupCountryCode(String value) =>
      ColiveAppPreference.box.put('currentTopupCountryCode', value);
}
