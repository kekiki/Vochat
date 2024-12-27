import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ColivePathUtil {
  ColivePathUtil._internal();

  static late final String _appFilePath;

  static String get appFilePath => _appFilePath;

  static Future<void> init() async {
    final documentDir = await getApplicationSupportDirectory();
    _appFilePath = documentDir.path;
  }

  static String get logPath =>
      "$_appFilePath${Platform.pathSeparator}log${Platform.pathSeparator}";

  static String get tempPath =>
      "$_appFilePath${Platform.pathSeparator}temp${Platform.pathSeparator}";

  static String get downloadPath =>
      "$_appFilePath${Platform.pathSeparator}downloads${Platform.pathSeparator}";
}
