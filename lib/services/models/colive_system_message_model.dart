//
//  ColiveSystemMessageModel.dart
//
//
//  Created by JSONConverter on 2024/12/02.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import '../config/colive_app_config.dart';

part 'colive_system_message_model.g.dart';

@JsonSerializable()
class ColiveSystemMessageModel extends Object {
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

  static ColiveSystemMessageModel createDefaultModel() {
    return ColiveSystemMessageModel(
      'colive_system_message_default_content'.tr,
      ColiveProfileManager.instance.userInfo.createTime,
      0,
      '',
      '',
      'colive_system_message_default_title_%s'
          .trArgs([ColiveAppConfig.appName]),
      0,
    );
  }

  ColiveSystemMessageModel(
    this.content,
    this.createTime,
    this.id,
    this.images,
    this.link,
    this.title,
    this.updateTime,
  );

  factory ColiveSystemMessageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveSystemMessageModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveSystemMessageModelToJson(this);
}
