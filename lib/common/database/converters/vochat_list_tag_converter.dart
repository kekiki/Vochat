import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../services/models/vochat_anchor_model.dart';

class VochatListTagConverter
    extends TypeConverter<List<VochatTagModel>, String> {
  @override
  List<VochatTagModel> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List<dynamic>?)
            ?.map((e) => VochatTagModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String encode(List<VochatTagModel> value) {
    return jsonEncode(value);
  }
}
