import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colive_search_history_model.g.dart';

@JsonSerializable()
@Entity(tableName: 'database_table_search_history')
class ColiveSearchHistoryModel {
  @primaryKey
  @JsonKey(name: 'history', defaultValue: '')
  final String history;
  @JsonKey(name: 'time', defaultValue: 0)
  final int time;

  ColiveSearchHistoryModel(this.history, this.time);

  factory ColiveSearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ColiveSearchHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColiveSearchHistoryModelToJson(this);
}
