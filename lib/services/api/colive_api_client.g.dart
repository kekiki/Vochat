// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ColiveApiClient implements ColiveApiClient {
  _ColiveApiClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ColiveApiResponse<bool>> checkVersionStatus(String version) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ios_version': version};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<bool>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/manage/check_ios_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<bool>.fromJson(
      _result.data!,
      (json) => json as bool,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveCustomCodeModel>> fetchVisitorAccount(
      String network) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'network': network};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveCustomCodeModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/visitor_account_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveCustomCodeModel>.fromJson(
      _result.data!,
      (json) => ColiveCustomCodeModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithCustomCode(
    String customCode,
    String password,
    String network,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'custom_code': customCode,
      'password': password,
      'network': network,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLoginModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/login_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLoginModel>.fromJson(
      _result.data!,
      (json) => ColiveLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithApple(
    String authorizationCode,
    String appleUserId,
    String network,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'authorizationCode': authorizationCode,
      'apple_user_id': appleUserId,
      'network': network,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLoginModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/apple_login_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLoginModel>.fromJson(
      _result.data!,
      (json) => ColiveLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithGoogle(
    String token,
    String avatar,
    String network, {
    String loginType = '2',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'account': token,
      'avatar': avatar,
      'network': network,
      'login_type': loginType,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLoginModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/third_login_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLoginModel>.fromJson(
      _result.data!,
      (json) => ColiveLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> deleteAccount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/cancellation_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> fetchCustomerServiceInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/kefuAccount_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLoginModelUser>> fetchUserInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLoginModelUser>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/user_info_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLoginModelUser>.fromJson(
      _result.data!,
      (json) => ColiveLoginModelUser.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLoginModelUser>> editUserInfo(
    String avatar,
    String nickname,
    String birthday,
    String signature,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'avatar': avatar,
      'nickname': nickname,
      'birthday': birthday,
      'signature': signature,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLoginModelUser>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/edit_all_user_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLoginModelUser>.fromJson(
      _result.data!,
      (json) => ColiveLoginModelUser.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> uploadImages(FormData data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = data;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/api/tweep/upload/multy_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveGiftBaseModel>> fetchGiftList(
      String giftType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'giftType': giftType};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveGiftBaseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/gift_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveGiftBaseModel>.fromJson(
      _result.data!,
      (json) => ColiveGiftBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> sendGift(
    String anchorId,
    String giftId,
    String num,
    String type,
    String conversationId,
    String isBackpack,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'gift_id': giftId,
      'num': num,
      's_type': type,
      'conversation_id': conversationId,
      'is_backpack': isBackpack,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/send_gift_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveFollowModel>>> fetchFollowList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveFollowModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/follow/follow_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveFollowModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveFollowModel>(
                  (i) => ColiveFollowModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> addFollow(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'follow_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/follow/add_follow_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> cancelFollow(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'follow_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/follow/cancel_follow_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveFollowerModel>>> fetchFansList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveFollowerModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/follow/fans_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveFollowerModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveFollowerModel>((i) =>
                  ColiveFollowerModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveBlockModel>>> fetchBlockList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveBlockModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/block_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveBlockModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveBlockModel>(
                  (i) => ColiveBlockModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> addBlock(
    String anchorId,
    String isRobot,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'block_id': anchorId,
      'isRobot': isRobot,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/block_user_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> cancelBlock(
    String anchorId,
    String isRobot,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'block_id': anchorId,
      'isRobot': isRobot,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/clear_block_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveChatBlockModel>> chatBlockInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'touid': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveChatBlockModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/chat_info_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveChatBlockModel>.fromJson(
      _result.data!,
      (json) => ColiveChatBlockModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> chatRecordInfo(
    String anchorId,
    String type,
    String message,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'touid': anchorId,
      'm_type': type,
      'message': message,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/chat_record_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveCardBaseModel>> fetchBackpackInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveCardBaseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/item/userBackpack_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveCardBaseModel>.fromJson(
      _result.data!,
      (json) => ColiveCardBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveCallRecordModel>>> fetchCallRecordList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveCallRecordModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/custom_conversation_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveCallRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveCallRecordModel>((i) =>
                  ColiveCallRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveGiftRecordModel>>> fetchGiftRecordList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveGiftRecordModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/gift_exchange_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveGiftRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveGiftRecordModel>((i) =>
                  ColiveGiftRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveSysRecordModel>>> fetchSysRecordList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveSysRecordModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/exchange_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveSysRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveSysRecordModel>((i) =>
                  ColiveSysRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveTopupRecordModel>>> fetchTopupRecordList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveTopupRecordModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/order_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveTopupRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveTopupRecordModel>((i) =>
                  ColiveTopupRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> feedback(
    String content,
    String images,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'content': content,
      'images': images,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/feedback_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveBannerModel>>> fetchBannerList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveBannerModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/banner_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveBannerModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveBannerModel>(
                  (i) => ColiveBannerModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveAreaModel>>> fetchAreaList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveAreaModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/area_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveAreaModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveAreaModel>(
                  (i) => ColiveAreaModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveAnchorModel>>> fetchAnchorList(
    String area,
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'area': area,
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveAnchorModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/dynamic/anchor_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveAnchorModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveAnchorModel>(
                  (i) => ColiveAnchorModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> searchAnchorList(String keyword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'key': keyword};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/searchAll_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> fetchActivityStatus() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/first_login_status_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> fetchNewUserReward() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/user/giveDiamondToNewUser_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveTurntableModel>> fetchTurntableList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveTurntableModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/activity/turntable_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveTurntableModel>.fromJson(
      _result.data!,
      (json) => ColiveTurntableModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveLuskyDrawModel>> requestDrawTurntable() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveLuskyDrawModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/activity/draw_turntable_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveLuskyDrawModel>.fromJson(
      _result.data!,
      (json) => ColiveLuskyDrawModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveTurntableRecordModel>>>
      fetchTurntableRecordList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveTurntableRecordModel>>>(
            Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
                .compose(
                  _dio.options,
                  '/api/tweep/activity/turntable_record_tweep',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                ))));
    final value = ColiveApiResponse<List<ColiveTurntableRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveTurntableRecordModel>((i) =>
                  ColiveTurntableRecordModel.fromJson(
                      i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveSystemMessageModel>>>
      fetchSystemMessageList(String page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveSystemMessageModel>>>(
            Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
                .compose(
                  _dio.options,
                  '/api/tweep/system/sms_tweep',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                ))));
    final value = ColiveApiResponse<List<ColiveSystemMessageModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveSystemMessageModel>((i) =>
                  ColiveSystemMessageModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> fetchMomentList(
    String country,
    String page,
    String size, {
    String update = '1',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'country': country,
      'page': page,
      'size': size,
      'isUpdate': update,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveMomentItemModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/dynamic/all_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveMomentItemModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveMomentItemModel>((i) =>
                  ColiveMomentItemModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> fetchMyMomentList(
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveMomentItemModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/dynamic/my_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveMomentItemModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveMomentItemModel>((i) =>
                  ColiveMomentItemModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> createMoment(
    String content,
    List<String> images,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'content': content,
      'images': images,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/tweep/dynamic/create_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> deleteMoment(String id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/dynamic/del_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveAnchorDetailModel>> fetchAnchorInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'anchor_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveAnchorDetailModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/information_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveAnchorDetailModel>.fromJson(
      _result.data!,
      (json) => ColiveAnchorDetailModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveAnchorDetailModel>> fetchRobotAnchorInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ai_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveAnchorDetailModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/robot/robotInfo_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveAnchorDetailModel>.fromJson(
      _result.data!,
      (json) => ColiveAnchorDetailModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> fetchAnchorMomentList(
    String anchorId,
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveMomentItemModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/visit_anchor_dynamic_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveMomentItemModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveMomentItemModel>((i) =>
                  ColiveMomentItemModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveAnchorModelVideo>>> fetchAnchorVideoList(
    String anchorId,
    String page,
    String size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'page': page,
      'size': size,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveAnchorModelVideo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/custom/visit_anchor_video_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveAnchorModelVideo>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveAnchorModelVideo>((i) =>
                  ColiveAnchorModelVideo.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveAnchorModelVideo>>>
      fetchRobotAnchorVideoList(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ai_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveAnchorModelVideo>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/robot/robotVideo_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveAnchorModelVideo>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveAnchorModelVideo>((i) =>
                  ColiveAnchorModelVideo.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveCallModel>> callCreate(
    String anchorId,
    String userId,
    String isRobot,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'custom_id': userId,
      'isAi': isRobot,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveCallModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/create_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveCallModel>.fromJson(
      _result.data!,
      (json) => ColiveCallModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callRefuse(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/refuse_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callTimeout(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/timeout_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callOn(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/on_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callSettlement(
      String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/settlement_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callAiAnswer() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/answer_ai_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callAiRefuse(
    String anchorId,
    String pushType,
    String isTimeOut,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'pushType': pushType,
      'isTimeOut': isTimeOut,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/refuse_ai_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> callAiHangup(
    String anchorId,
    String url,
    String isFinish,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'anchor_id': anchorId,
      'url': url,
      'isFinish': isFinish,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/conversation/hangup_ai_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<ColiveProductBaseModel>> fetchProductList(
      String type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<ColiveProductBaseModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/order/pay_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<ColiveProductBaseModel>.fromJson(
      _result.data!,
      (json) => ColiveProductBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<List<ColiveChannelItemModel>>> fetchChannelList(
    String payId,
    String country,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'payId': payId,
      'country': country,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<List<ColiveChannelItemModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/tweep/order/pay_channel_list_tweep',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<List<ColiveChannelItemModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ColiveChannelItemModel>((i) =>
                  ColiveChannelItemModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> verifyOrderAndroid(
    String orderToken,
    String packageName,
    String productId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'order_token': orderToken,
      'packageName': packageName,
      'product_id': productId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/order/google_pay_notify',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ColiveApiResponse<dynamic>> verifyOrderIOS(
    String receipt,
    String orderId,
    String transactionId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'receipt': receipt,
      'order_no': orderId,
      'transaction_id': transactionId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ColiveApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/order/recharge_ios',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ColiveApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
