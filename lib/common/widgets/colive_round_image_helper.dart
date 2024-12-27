class ColiveRoundImageHelper {
  /// 单例
  static ColiveRoundImageHelper? _instance;
  static ColiveRoundImageHelper get instance =>
      _instance ??= ColiveRoundImageHelper._internal();
  ColiveRoundImageHelper._internal();

  final _cacheMap = {};

  bool hasCache(String key) => _cacheMap.containsKey(key);

  dynamic getValue(String key) => _cacheMap[key];

  void addCache({required String key, required dynamic value}) =>
      _cacheMap[key] = value;

  void removeCache(String key) => _cacheMap.remove(key);

  void clear() => _cacheMap.clear();
}
