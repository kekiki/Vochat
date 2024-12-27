import 'dart:convert';

import 'package:floor/floor.dart';

class ColiveListStringConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    var value = jsonDecode(databaseValue);
    return (value as List<dynamic>?)?.map((e) => e as String).toList() ?? [];
  }

  @override
  String encode(List<String> value) {
    return jsonEncode(value);
  }
}
