import 'dart:async';

import 'package:dio/dio.dart';
import 'package:vochat/services/models/vochat_product_base_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../login/models/cochat_user_model.dart';
import '../../services/models/vochat_anchor_model.dart';
import '../../services/models/vochat_api_response.dart';
import '../../services/models/vochat_area_model.dart';
import '../../services/models/vochat_banner_model.dart';
import '../../services/models/vochat_block_model.dart';
import '../../services/models/vochat_call_model.dart';
import '../../services/models/vochat_card_base_model.dart';
import '../../services/models/vochat_call_record_model.dart';
import '../../services/models/vochat_channel_item_model.dart';
import '../../services/models/vochat_chat_block_model.dart';
import '../../services/models/vochat_custom_code_model.dart';
import '../../services/models/vochat_follow_model.dart';
import '../../services/models/vochat_follower_model.dart';
import '../../services/models/vochat_gift_base_model.dart';
import '../../services/models/vochat_gift_record_model.dart';
import '../../services/models/vochat_login_model.dart';
import '../../services/models/vochat_sys_record_model.dart';
import '../../services/models/vochat_system_message_model.dart';
import '../../services/models/vochat_topup_record_model.dart';
import '../../services/models/vochat_turntable_model.dart';
import '../../services/models/vochat_turntable_record_model.dart';
part 'vochat_api_client.g.dart';

const _appName = 'tweep';

const kApiUrlCreateOrder = '/v3/pay/creatOrder?server=1';

@RestApi()
abstract class VochatApiClient {
  factory VochatApiClient(Dio dio) = _VochatApiClient;

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Login API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/guest_login')
  @FormUrlEncoded()
  Future<VochatApiResponse<CochatUserModel>> guestLogin();

  @POST('/api/apple_login')
  @FormUrlEncoded()
  Future<VochatApiResponse<CochatUserModel>> appleLogin({
    @Field('apple_user_id') required String appleUserId,
    @Field('authorizationCode') required String authorizationCode,
  });

  @POST('/api/$_appName/custom/third_login_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<CochatUserModel>> googleLogin({
    @Field('account') required String token,
    @Field('avatar') required String avatar,
  });

  @POST('/api/registered')
  @FormUrlEncoded()
  Future<VochatApiResponse<CochatUserModel>> registerUserInfo({
    @Field('headimgurl') required String avatar,
    @Field('nickname') required String nickname,
    @Field('birthday') required String birthday,
    @Field('sex') required String gender,
    @Field('system') required String system,
    @Field('apple_user_id') String appleUserId = '',
  });

  @POST('/api/get_user_info')
  @FormUrlEncoded()
  Future<VochatApiResponse<CochatUserModel>> fetchUserInfo({
    @Field('user_id') required String userId,
  });

  // /////////////////////////////////////////////////////////////////////////////
  // //////////////////////////////// iOS API
  // /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/manage/check_ios_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<bool>> checkVersionStatus(
    @Field('ios_version') String version,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Account API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/custom/visitor_account_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatCustomCodeModel>> fetchVisitorAccount(
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/login_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatLoginModel>> loginWithCustomCode(
    @Field('custom_code') String customCode,
    @Field('password') String password,
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/apple_login_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatLoginModel>> loginWithApple(
    @Field('authorizationCode') String authorizationCode,
    @Field('apple_user_id') String appleUserId,
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/third_login_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatLoginModel>> loginWithGoogle(
    @Field('account') String token,
    @Field('avatar') String avatar,
    @Field('network') String network, {
    @Field('login_type') String loginType = '2',
  });

  @POST('/api/$_appName/user/cancellation_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> deleteAccount();

  @POST('/api/$_appName/user/kefuAccount_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> fetchCustomerServiceInfo();

  @POST('/api/$_appName/user/edit_all_user_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatLoginModelUser>> editUserInfo(
    @Field('avatar') String avatar,
    @Field('nickname') String nickname,
    @Field('birthday') String birthday,
    @Field('signature') String signature,
  );

  @POST('/api/$_appName/upload/multy_$_appName')
  @MultiPart()
  Future<VochatApiResponse<dynamic>> uploadImages(
    @Body() FormData data,
  );

  @POST('/api/$_appName/custom/gift_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatGiftBaseModel>> fetchGiftList(
    @Field('giftType') String giftType, //0 全部返回, 1普通礼物 2vip礼物 3背包礼物
  );

  @POST('/api/$_appName/custom/send_gift_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> sendGift(
    @Field('anchor_id') String anchorId,
    @Field('gift_id') String giftId,
    @Field('num') String num,
    @Field('s_type') String type,
    @Field('conversation_id') String conversationId,
    @Field('is_backpack') String isBackpack, //0钻石送礼 1背包送礼
  );

  @POST('/api/$_appName/follow/follow_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatFollowModel>>> fetchFollowList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/follow/add_follow_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> addFollow(
    @Field('follow_id') String anchorId,
  );

  @POST('/api/$_appName/follow/cancel_follow_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> cancelFollow(
    @Field('follow_id') String anchorId,
  );

  @POST('/api/$_appName/follow/fans_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatFollowerModel>>> fetchFansList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/block_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatBlockModel>>> fetchBlockList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/block_user_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> addBlock(
    @Field('block_id') String anchorId,
    @Field('isRobot') String isRobot,
  );

  @POST('/api/$_appName/user/clear_block_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> cancelBlock(
    @Field('block_id') String anchorId,
    @Field('isRobot') String isRobot,
  );

  @POST('/api/$_appName/user/chat_info_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatChatBlockModel>> chatBlockInfo(
    @Field('touid') String anchorId,
  );

  @POST('/api/$_appName/user/chat_record_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> chatRecordInfo(
    @Field('touid') String anchorId,
    @Field('m_type') String type, // text '1', image '2', emoji '3'
    @Field('message') String message,
  );

  @POST('/api/$_appName/item/userBackpack_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatCardBaseModel>> fetchBackpackInfo();

  @POST('/api/$_appName/custom/custom_conversation_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatCallRecordModel>>> fetchCallRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/gift_exchange_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatGiftRecordModel>>> fetchGiftRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/exchange_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatSysRecordModel>>> fetchSysRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/order_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatTopupRecordModel>>> fetchTopupRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/feedback_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> feedback(
    @Field('content') String content,
    @Field('images') String images,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Home API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/user/banner_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatBannerModel>>> fetchBannerList();

  @POST('/api/$_appName/user/area_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatAreaModel>>> fetchAreaList();

  @POST('/api/$_appName/dynamic/anchor_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatAnchorModel>>> fetchAnchorList(
    @Field('area') String area,
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/searchAll_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> searchAnchorList(
    @Field('key') String keyword,
  );

  @POST('/api/$_appName/custom/first_login_status_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> fetchActivityStatus();

  @POST('/api/$_appName/user/giveDiamondToNewUser_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> fetchNewUserReward();

  @POST('/api/$_appName/activity/turntable_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatTurntableModel>> fetchTurntableList();

  @POST('/api/$_appName/activity/draw_turntable_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatLuskyDrawModel>> requestDrawTurntable();

  @POST('/api/$_appName/activity/turntable_record_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatTurntableRecordModel>>>
      fetchTurntableRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/system/sms_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatSystemMessageModel>>>
      fetchSystemMessageList(
    @Field('page') String page,
  );

// // 每日上线领取奖励信息
// String vipDailyBonus_tweep =
//     'api/$appNameSmall/order/vipDailyBonus_$appNameSmall';
// // 领取VIP每日奖励
// String receiveVipDailyBonus_tweep =
//     'api/$appNameSmall/order/receiveVipDailyBonus_$appNameSmall';

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Anchor API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/custom/information_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatAnchorDetailModel>> fetchAnchorInfo(
    @Field('anchor_id') String anchorId,
  );

  @POST('/api/$_appName/robot/robotInfo_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatAnchorDetailModel>> fetchRobotAnchorInfo(
    @Field('ai_id') String anchorId,
  );

  @POST('/api/$_appName/custom/visit_anchor_video_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatAnchorModelVideo>>> fetchAnchorVideoList(
    @Field('anchor_id') String anchorId,
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/robot/robotVideo_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatAnchorModelVideo>>>
      fetchRobotAnchorVideoList(
    @Field('ai_id') String anchorId,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Call API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/conversation/create_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatCallModel>> callCreate(
    @Field('anchor_id') String anchorId,
    @Field('custom_id') String userId,
    @Field('isAi') String isRobot,
  );

  @POST('/api/$_appName/conversation/refuse_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callRefuse(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/timeout_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callTimeout(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/on_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callOn(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/settlement_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callSettlement(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/answer_ai_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callAiAnswer();

  @POST('/api/$_appName/conversation/refuse_ai_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callAiRefuse(
    @Field('anchor_id') String anchorId,
    @Field('pushType') String pushType,
    @Field('isTimeOut') String isTimeOut,
  );

  @POST('/api/$_appName/conversation/hangup_ai_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> callAiHangup(
    @Field('anchor_id') String anchorId,
    @Field('url') String url,
    @Field('isFinish') String isFinish,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Order API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/order/pay_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<VochatProductBaseModel>> fetchProductList(
    @Field('type') String type, //1 diamonds, 2 vip, 3 promotions
  );

  @POST('/api/$_appName/order/pay_channel_list_$_appName')
  @FormUrlEncoded()
  Future<VochatApiResponse<List<VochatChannelItemModel>>> fetchChannelList(
    @Field('payId') String payId,
    @Field('country') String country,
  );

  @POST('/api/order/google_pay_notify') // Android
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> verifyOrderAndroid(
    @Field('order_token') String orderToken,
    @Field('packageName') String packageName,
    @Field('product_id') String productId,
  );

  @POST('/api/order/recharge_ios') // iOS
  @FormUrlEncoded()
  Future<VochatApiResponse<dynamic>> verifyOrderIOS(
    @Field('receipt') String receipt,
    @Field('order_no') String orderId,
    @Field('transaction_id') String transactionId,
  );
}
