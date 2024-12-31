import 'package:json_annotation/json_annotation.dart';

part 'vochat_chat_block_model.g.dart';

@JsonSerializable()
class VochatChatBlockModel extends Object {
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

  VochatChatBlockModel(
    this.area,
    this.chatNum,
    this.isBeBlock,
    this.isToBlock,
  );

  VochatChatBlockModel copyWith({
    String? area,
    int? chatNum,
    bool? isBeBlock,
    bool? isToBlock,
  }) {
    return VochatChatBlockModel(
      area ?? this.area,
      chatNum ?? this.chatNum,
      isBeBlock ?? this.isBeBlock,
      isToBlock ?? this.isToBlock,
    );
  }

  factory VochatChatBlockModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatChatBlockModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatChatBlockModelToJson(this);
}
