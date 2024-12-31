//
//  VochatSystemMessageModel.dart
//
//
//  Created by JSONConverter on 2024/12/02.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../login/managers/vochat_profile_manager.dart';

part 'vochat_system_message_model.g.dart';

@JsonSerializable()
class VochatSystemMessageModel extends Object {
  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'images', defaultValue: '')
  final String images;

  @JsonKey(name: 'link', defaultValue: '')
  final String link;

  @JsonKey(name: 'title', defaultValue: '')
  final String title;

  @JsonKey(name: 'update_time', defaultValue: 0)
  final int updateTime;

  static VochatSystemMessageModel createDefaultModel() {
    return VochatSystemMessageModel('vochat_system_message_default_content'.tr,
        VochatProfileManager.instance.userInfo.createTime, 0, '', '', '', 0);
  }

  VochatSystemMessageModel(
    this.content,
    this.createTime,
    this.id,
    this.images,
    this.link,
    this.title,
    this.updateTime,
  );

  factory VochatSystemMessageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatSystemMessageModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatSystemMessageModelToJson(this);
}
