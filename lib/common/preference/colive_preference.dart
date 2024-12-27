import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ColiveAppPreference {
  static late Box _box;
  static Box get box => _box;

  ColiveAppPreference._internal();

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
}
