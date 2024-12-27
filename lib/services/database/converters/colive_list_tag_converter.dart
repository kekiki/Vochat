import 'dart:convert';

import 'package:floor/floor.dart';

import '../../models/colive_anchor_model.dart';

class ColiveListTagConverter
    extends TypeConverter<List<ColiveTagModel>, String> {
  @override
  List<ColiveTagModel> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) => ColiveTagModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<ColiveTagModel> value) {
    return jsonEncode(value);
  }
}
