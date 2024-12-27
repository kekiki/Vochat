import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colive_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ColiveApiResponse<T> {
  //  业务处理状态码 200为正常 其他为错误
  @JsonKey(name: 'code', defaultValue: -1)
  final int code;

  // 业务处理状态提示  状态码非200时可展示此字段
  @JsonKey(name: 'message', defaultValue: '')
  final String msg;

  // data
  @JsonKey(name: 'data', defaultValue: null)
  final T? data;

  ColiveApiResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  bool get isSuccess => code == 200;
  bool get isTokenExpired => code == 401;
  bool get isAccountBanned => code == 402;

  @override
  String toString() {
    return 'ColiveApiResponse{code: $code, msg: $msg, data: $data}';
  }

  factory ColiveApiResponse.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      // _$ColiveApiResponseFromJson(json, fromJsonT);
      _$fixedColiveApiResponseFromJson(json, fromJsonT);

  ColiveApiResponse<T> copyWith({
    int? code,
    String? msg,
    T? data,
  }) {
    return ColiveApiResponse(
      code: code ?? this.code,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }
}

/// 服务端在返回的数据结构中，如果List为空，有几率出现不返回data字段的情况，
/// {code=0, msg=success}
ColiveApiResponse<T> _$fixedColiveApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  final code = json['code'] as int? ?? -1;
  final msg = json['message'] as String? ?? 'colive_request_failed'.tr;
  final data = _$nullableGenericFromJson(json["data"], fromJsonT);
  if (code == 0 && data == null) {
    final genericType = T.toString();
    T? generateData;
    if (genericType.startsWith("List")) {
      generateData = _$nullableGenericFromJson([], fromJsonT);
    } else {
      generateData = _$nullableGenericFromJson({}, fromJsonT);
    }
    return ColiveApiResponse<T>(code: code, msg: msg, data: generateData);
  }
  return ColiveApiResponse<T>(code: code, msg: msg, data: data);
}
