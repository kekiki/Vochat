import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vochat_search_history_model.g.dart';

@JsonSerializable()
@Entity(tableName: 'database_table_search_history')
class VochatSearchHistoryModel {
  @primaryKey
  @JsonKey(name: 'history', defaultValue: '')
  final String history;
  @JsonKey(name: 'time', defaultValue: 0)
  final int time;

  VochatSearchHistoryModel(this.history, this.time);

  factory VochatSearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$VochatSearchHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$VochatSearchHistoryModelToJson(this);
}
