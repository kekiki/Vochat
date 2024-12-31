import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class VochatPreference {
  static late Box _box;
  static Box get box => _box;

  VochatPreference._internal();

  static Future<void> init() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    _box = await Hive.openBox('preference');
    return Future.value(null);
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  static set isAppFirstLaunch(bool isFirst) =>
      _box.put('isAppFirstLaunch', isFirst);

  static bool get isAppFirstLaunch =>
      _box.get('isAppFirstLaunch', defaultValue: true);

  static bool get isProductionServer =>
      _box.get('isProductionServer', defaultValue: false);

  static set isProductionServer(bool value) =>
      _box.put('isProductionServer', value);

  // accept privacy policy and terms of use
  static bool get acceptPrivacyPolicy =>
      _box.get('acceptPrivacyPolicy', defaultValue: false);

  static set acceptPrivacyPolicy(bool value) =>
      _box.put('acceptPrivacyPolicy', value);

  // language code
  static String get languageCode => _box.get('languageCode', defaultValue: '');

  static set languageCode(String value) => _box.put('languageCode', value);

  // appsflyer
  static set afid(String afid) => _box.put('afid', afid);

  static String get afid => _box.get('afid', defaultValue: '');

  // iOS idfa
  static set adid(String network) => _box.put('adid', network);

  static String get adid => _box.get('adid', defaultValue: '');

  // dt id
  static set dtId(String dtId) => _box.put('dtId', dtId);

  static String get dtId => _box.get('dtId', defaultValue: '');

  // referrer
  static set installReferrer(String referrer) =>
      _box.put('installReferrer', referrer);

  static String get installReferrer =>
      _box.get('installReferrer', defaultValue: '');

  // user token
  static set token(String value) => _box.put('token', value);

  static String get token => _box.get('token', defaultValue: '');

  // user id
  static String get userId => _box.get('userId', defaultValue: '');

  static set userId(String value) => _box.put('userId', value);

  // user info
  static set userInfoJson(Map<dynamic, dynamic> value) =>
      _box.put('userInfoJson', jsonEncode(value));

  static Map<String, dynamic> get userInfoJson =>
      jsonDecode(_box.get('userInfoJson', defaultValue: '{}'));

  // customer service id
  static String get customerServiceId =>
      _box.get('customerServiceId', defaultValue: '');

  static set customerServiceId(String value) =>
      _box.put('customerServiceId', value);

  // current area
  static String get currentArea => _box.get('currentArea', defaultValue: '');

  static set currentArea(String value) => _box.put('currentArea', value);

  // area list
  static set areList(List value) => _box.put('areList', jsonEncode(value));

  static List get areList => jsonDecode(_box.get('areList', defaultValue: []));

  // No Disturb Mode
  static bool get isNoDisturbMode =>
      _box.get('isNoDisturbMode', defaultValue: false);

  static set isNoDisturbMode(bool value) => _box.put('isNoDisturbMode', value);

  // gift info
  static set giftInfoJson(Map<String, dynamic> value) =>
      _box.put('giftInfoJson', jsonEncode(value));

  static Map<String, dynamic> get giftInfoJson =>
      jsonDecode(_box.get('giftInfoJson', defaultValue: '{}'));

  // current topup country
  static String get currentTopupCountryCode =>
      _box.get('currentTopupCountryCode', defaultValue: '');

  static set currentTopupCountryCode(String value) =>
      _box.put('currentTopupCountryCode', value);
}
