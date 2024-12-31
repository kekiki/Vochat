import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../services/models/vochat_anchor_model.dart';

class VochatListAlbumConverter
    extends TypeConverter<List<VochatAnchorModelAlbum>, String> {
  @override
  List<VochatAnchorModelAlbum> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) =>
                VochatAnchorModelAlbum.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<VochatAnchorModelAlbum> value) {
    return jsonEncode(value);
  }
}
