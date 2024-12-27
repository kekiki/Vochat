import 'dart:convert';

import 'package:floor/floor.dart';

import '../../models/colive_anchor_model.dart';

class ColiveListAlbumConverter
    extends TypeConverter<List<ColiveAnchorModelAlbum>, String> {
  @override
  List<ColiveAnchorModelAlbum> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) =>
                ColiveAnchorModelAlbum.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<ColiveAnchorModelAlbum> value) {
    return jsonEncode(value);
  }
}
