import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vochat_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class VochatApiResponse<T> {
  //  业务处理状态码 200为正常 其他为错误
  @JsonKey(name: 'code', defaultValue: -1)
  final int code;

  // 业务处理状态提示  状态码非200时可展示此字段
  @JsonKey(name: 'message', defaultValue: '')
  final String msg;

  // data
  @JsonKey(name: 'data', defaultValue: null)
  final T? data;

  VochatApiResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  bool get isSuccess => code == 1;
  bool get isTokenExpired => code == 2;

  @override
  String toString() {
    return 'VochatApiResponse{code: $code, msg: $msg, data: $data}';
  }

  factory VochatApiResponse.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      // _$VochatApiResponseFromJson(json, fromJsonT);
      _$fixedVochatApiResponseFromJson(json, fromJsonT);

  VochatApiResponse<T> copyWith({
    int? code,
    String? msg,
    T? data,
  }) {
    return VochatApiResponse(
      code: code ?? this.code,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }
}

/// 服务端在返回的数据结构中，如果List为空，有几率出现不返回data字段的情况，
/// {code=0, msg=success}
VochatApiResponse<T> _$fixedVochatApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  final code = json['code'] as int? ?? -1;
  final msg = json['message'] as String? ?? 'vochat_request_failed'.tr;
  final data = _$nullableGenericFromJson(json["data"], fromJsonT);
  if (code == 0 && data == null) {
    final genericType = T.toString();
    T? generateData;
    if (genericType.startsWith("List")) {
      generateData = _$nullableGenericFromJson([], fromJsonT);
    } else {
      generateData = _$nullableGenericFromJson({}, fromJsonT);
    }
    return VochatApiResponse<T>(code: code, msg: msg, data: generateData);
  }
  return VochatApiResponse<T>(code: code, msg: msg, data: data);
}
