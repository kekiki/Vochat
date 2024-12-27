import 'dart:convert';

import 'package:floor/floor.dart';

import '../../models/colive_anchor_model.dart';

class ColiveListVideoConverter
    extends TypeConverter<List<ColiveAnchorModelVideo>, String> {
  @override
  List<ColiveAnchorModelVideo> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) =>
                ColiveAnchorModelVideo.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<ColiveAnchorModelVideo> value) {
    return jsonEncode(value);
  }
}
