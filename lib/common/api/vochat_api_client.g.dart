// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _VochatApiClient implements VochatApiClient {
  _VochatApiClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<VochatApiResponse<CochatUserModel>> guestLogin() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<CochatUserModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/guest_login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = VochatApiResponse<CochatUserModel>.fromJson(
      _result.data!,
      (json) => CochatUserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<CochatUserModel>> appleLogin({
    required String appleUserId,
    required String authorizationCode,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'apple_user_id': appleUserId,
      'authorizationCode': authorizationCode,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<CochatUserModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/apple_login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = VochatApiResponse<CochatUserModel>.fromJson(
      _result.data!,
      (json) => CochatUserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<CochatUserModel>> googleLogin({
    required String token,
    required String avatar,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'account': token,
      'avatar': avatar,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<CochatUserModel>>(Options(
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
    final value = VochatApiResponse<CochatUserModel>.fromJson(
      _result.data!,
      (json) => CochatUserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<CochatUserModel>> registerUserInfo({
    required String avatar,
    required String nickname,
    required String birthday,
    required String gender,
    required String system,
    String appleUserId = '',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'headimgurl': avatar,
      'nickname': nickname,
      'birthday': birthday,
      'sex': gender,
      'system': system,
      'apple_user_id': appleUserId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<CochatUserModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/registered',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = VochatApiResponse<CochatUserModel>.fromJson(
      _result.data!,
      (json) => CochatUserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<CochatUserModel>> fetchUserInfo(
      {required String userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'user_id': userId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<CochatUserModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/get_user_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = VochatApiResponse<CochatUserModel>.fromJson(
      _result.data!,
      (json) => CochatUserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<bool>> checkVersionStatus(String version) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ios_version': version};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<bool>>(Options(
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
    final value = VochatApiResponse<bool>.fromJson(
      _result.data!,
      (json) => json as bool,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatCustomCodeModel>> fetchVisitorAccount(
      String network) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'network': network};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatCustomCodeModel>>(Options(
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
    final value = VochatApiResponse<VochatCustomCodeModel>.fromJson(
      _result.data!,
      (json) => VochatCustomCodeModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatLoginModel>> loginWithCustomCode(
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
        _setStreamType<VochatApiResponse<VochatLoginModel>>(Options(
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
    final value = VochatApiResponse<VochatLoginModel>.fromJson(
      _result.data!,
      (json) => VochatLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatLoginModel>> loginWithApple(
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
        _setStreamType<VochatApiResponse<VochatLoginModel>>(Options(
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
    final value = VochatApiResponse<VochatLoginModel>.fromJson(
      _result.data!,
      (json) => VochatLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatLoginModel>> loginWithGoogle(
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
        _setStreamType<VochatApiResponse<VochatLoginModel>>(Options(
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
    final value = VochatApiResponse<VochatLoginModel>.fromJson(
      _result.data!,
      (json) => VochatLoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> deleteAccount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> fetchCustomerServiceInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatLoginModelUser>> editUserInfo(
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
        _setStreamType<VochatApiResponse<VochatLoginModelUser>>(Options(
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
    final value = VochatApiResponse<VochatLoginModelUser>.fromJson(
      _result.data!,
      (json) => VochatLoginModelUser.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> uploadImages(FormData data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = data;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatGiftBaseModel>> fetchGiftList(
      String giftType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'giftType': giftType};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatGiftBaseModel>>(Options(
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
    final value = VochatApiResponse<VochatGiftBaseModel>.fromJson(
      _result.data!,
      (json) => VochatGiftBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> sendGift(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatFollowModel>>> fetchFollowList(
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
        _setStreamType<VochatApiResponse<List<VochatFollowModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatFollowModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatFollowModel>(
                  (i) => VochatFollowModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> addFollow(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'follow_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> cancelFollow(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'follow_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatFollowerModel>>> fetchFansList(
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
        _setStreamType<VochatApiResponse<List<VochatFollowerModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatFollowerModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatFollowerModel>((i) =>
                  VochatFollowerModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatBlockModel>>> fetchBlockList(
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
        _setStreamType<VochatApiResponse<List<VochatBlockModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatBlockModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatBlockModel>(
                  (i) => VochatBlockModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> addBlock(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> cancelBlock(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatChatBlockModel>> chatBlockInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'touid': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatChatBlockModel>>(Options(
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
    final value = VochatApiResponse<VochatChatBlockModel>.fromJson(
      _result.data!,
      (json) => VochatChatBlockModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> chatRecordInfo(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatCardBaseModel>> fetchBackpackInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatCardBaseModel>>(Options(
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
    final value = VochatApiResponse<VochatCardBaseModel>.fromJson(
      _result.data!,
      (json) => VochatCardBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatCallRecordModel>>> fetchCallRecordList(
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
        _setStreamType<VochatApiResponse<List<VochatCallRecordModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatCallRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatCallRecordModel>((i) =>
                  VochatCallRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatGiftRecordModel>>> fetchGiftRecordList(
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
        _setStreamType<VochatApiResponse<List<VochatGiftRecordModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatGiftRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatGiftRecordModel>((i) =>
                  VochatGiftRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatSysRecordModel>>> fetchSysRecordList(
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
        _setStreamType<VochatApiResponse<List<VochatSysRecordModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatSysRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatSysRecordModel>((i) =>
                  VochatSysRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatTopupRecordModel>>> fetchTopupRecordList(
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
        _setStreamType<VochatApiResponse<List<VochatTopupRecordModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatTopupRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatTopupRecordModel>((i) =>
                  VochatTopupRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> feedback(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatBannerModel>>> fetchBannerList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<List<VochatBannerModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatBannerModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatBannerModel>(
                  (i) => VochatBannerModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatAreaModel>>> fetchAreaList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<List<VochatAreaModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatAreaModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatAreaModel>(
                  (i) => VochatAreaModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatAnchorModel>>> fetchAnchorList(
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
        _setStreamType<VochatApiResponse<List<VochatAnchorModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatAnchorModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatAnchorModel>(
                  (i) => VochatAnchorModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> searchAnchorList(String keyword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'key': keyword};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> fetchActivityStatus() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> fetchNewUserReward() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatTurntableModel>> fetchTurntableList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatTurntableModel>>(Options(
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
    final value = VochatApiResponse<VochatTurntableModel>.fromJson(
      _result.data!,
      (json) => VochatTurntableModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatLuskyDrawModel>> requestDrawTurntable() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatLuskyDrawModel>>(Options(
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
    final value = VochatApiResponse<VochatLuskyDrawModel>.fromJson(
      _result.data!,
      (json) => VochatLuskyDrawModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatTurntableRecordModel>>>
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
        _setStreamType<VochatApiResponse<List<VochatTurntableRecordModel>>>(
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
    final value = VochatApiResponse<List<VochatTurntableRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatTurntableRecordModel>((i) =>
                  VochatTurntableRecordModel.fromJson(
                      i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatSystemMessageModel>>>
      fetchSystemMessageList(String page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<List<VochatSystemMessageModel>>>(
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
    final value = VochatApiResponse<List<VochatSystemMessageModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatSystemMessageModel>((i) =>
                  VochatSystemMessageModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatAnchorDetailModel>> fetchAnchorInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'anchor_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatAnchorDetailModel>>(Options(
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
    final value = VochatApiResponse<VochatAnchorDetailModel>.fromJson(
      _result.data!,
      (json) => VochatAnchorDetailModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatAnchorDetailModel>> fetchRobotAnchorInfo(
      String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ai_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatAnchorDetailModel>>(Options(
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
    final value = VochatApiResponse<VochatAnchorDetailModel>.fromJson(
      _result.data!,
      (json) => VochatAnchorDetailModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatAnchorModelVideo>>> fetchAnchorVideoList(
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
        _setStreamType<VochatApiResponse<List<VochatAnchorModelVideo>>>(Options(
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
    final value = VochatApiResponse<List<VochatAnchorModelVideo>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatAnchorModelVideo>((i) =>
                  VochatAnchorModelVideo.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatAnchorModelVideo>>>
      fetchRobotAnchorVideoList(String anchorId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'ai_id': anchorId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<List<VochatAnchorModelVideo>>>(Options(
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
    final value = VochatApiResponse<List<VochatAnchorModelVideo>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatAnchorModelVideo>((i) =>
                  VochatAnchorModelVideo.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatCallModel>> callCreate(
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
        _setStreamType<VochatApiResponse<VochatCallModel>>(Options(
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
    final value = VochatApiResponse<VochatCallModel>.fromJson(
      _result.data!,
      (json) => VochatCallModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callRefuse(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callTimeout(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callOn(String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callSettlement(
      String conversationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callAiAnswer() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callAiRefuse(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> callAiHangup(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<VochatProductBaseModel>> fetchProductList(
      String type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VochatApiResponse<VochatProductBaseModel>>(Options(
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
    final value = VochatApiResponse<VochatProductBaseModel>.fromJson(
      _result.data!,
      (json) => VochatProductBaseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<List<VochatChannelItemModel>>> fetchChannelList(
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
        _setStreamType<VochatApiResponse<List<VochatChannelItemModel>>>(Options(
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
    final value = VochatApiResponse<List<VochatChannelItemModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<VochatChannelItemModel>((i) =>
                  VochatChannelItemModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> verifyOrderAndroid(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<VochatApiResponse<dynamic>> verifyOrderIOS(
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
        _setStreamType<VochatApiResponse<dynamic>>(Options(
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
    final value = VochatApiResponse<dynamic>.fromJson(
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
