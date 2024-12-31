import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../services/models/vochat_anchor_model.dart';

class VochatListVideoConverter
    extends TypeConverter<List<VochatAnchorModelVideo>, String> {
  @override
  List<VochatAnchorModelVideo> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) =>
                VochatAnchorModelVideo.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<VochatAnchorModelVideo> value) {
    return jsonEncode(value);
  }
}
