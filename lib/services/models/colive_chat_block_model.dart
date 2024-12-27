import 'package:json_annotation/json_annotation.dart';

part 'colive_chat_block_model.g.dart';

@JsonSerializable()
class ColiveChatBlockModel extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'chat_num', defaultValue: 0)
  final int chatNum;

  /// 被拉黑
  @JsonKey(name: 'is_block', defaultValue: false)
  final bool isBeBlock;

  /// 已拉黑
  @JsonKey(name: 'is_toblock', defaultValue: false)
  final bool isToBlock;

  ColiveChatBlockModel(
    this.area,
    this.chatNum,
    this.isBeBlock,
    this.isToBlock,
  );

  ColiveChatBlockModel copyWith({
    String? area,
    int? chatNum,
    bool? isBeBlock,
    bool? isToBlock,
  }) {
    return ColiveChatBlockModel(
      area ?? this.area,
      chatNum ?? this.chatNum,
      isBeBlock ?? this.isBeBlock,
      isToBlock ?? this.isToBlock,
    );
  }

  factory ColiveChatBlockModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveChatBlockModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveChatBlockModelToJson(this);
}
