import 'dart:async';

import 'package:dio/dio.dart';
import 'package:colive/services/models/colive_product_base_model.dart';
import 'package:retrofit/retrofit.dart';

import '../models/colive_anchor_model.dart';
import '../models/colive_api_response.dart';
import '../models/colive_area_model.dart';
import '../models/colive_banner_model.dart';
import '../models/colive_block_model.dart';
import '../models/colive_call_model.dart';
import '../models/colive_card_base_model.dart';
import '../models/colive_call_record_model.dart';
import '../models/colive_channel_item_model.dart';
import '../models/colive_chat_block_model.dart';
import '../models/colive_custom_code_model.dart';
import '../models/colive_follow_model.dart';
import '../models/colive_follower_model.dart';
import '../models/colive_gift_base_model.dart';
import '../models/colive_gift_record_model.dart';
import '../models/colive_login_model.dart';
import '../models/colive_moment_item_model.dart';
import '../models/colive_sys_record_model.dart';
import '../models/colive_system_message_model.dart';
import '../models/colive_topup_record_model.dart';
import '../models/colive_turntable_model.dart';
import '../models/colive_turntable_record_model.dart';
part 'colive_api_client.g.dart';

const _appName = 'tweep';

const kApiUrlCreateOrder = '/v3/pay/creatOrder?server=1';

@RestApi()
abstract class ColiveApiClient {
  factory ColiveApiClient(Dio dio) = _ColiveApiClient;

  // /////////////////////////////////////////////////////////////////////////////
  // //////////////////////////////// iOS API
  // /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/manage/check_ios_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<bool>> checkVersionStatus(
    @Field('ios_version') String version,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Account API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/custom/visitor_account_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveCustomCodeModel>> fetchVisitorAccount(
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/login_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithCustomCode(
    @Field('custom_code') String customCode,
    @Field('password') String password,
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/apple_login_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithApple(
    @Field('authorizationCode') String authorizationCode,
    @Field('apple_user_id') String appleUserId,
    @Field('network') String network,
  );

  @POST('/api/$_appName/custom/third_login_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLoginModel>> loginWithGoogle(
    @Field('account') String token,
    @Field('avatar') String avatar,
    @Field('network') String network, {
    @Field('login_type') String loginType = '2',
  });

  @POST('/api/$_appName/user/cancellation_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> deleteAccount();

  @POST('/api/$_appName/user/kefuAccount_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> fetchCustomerServiceInfo();

  @POST('/api/$_appName/user/user_info_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLoginModelUser>> fetchUserInfo();

  @POST('/api/$_appName/user/edit_all_user_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLoginModelUser>> editUserInfo(
    @Field('avatar') String avatar,
    @Field('nickname') String nickname,
    @Field('birthday') String birthday,
    @Field('signature') String signature,
  );

  @POST('/api/$_appName/upload/multy_$_appName')
  @MultiPart()
  Future<ColiveApiResponse<dynamic>> uploadImages(
    @Body() FormData data,
  );

  @POST('/api/$_appName/custom/gift_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveGiftBaseModel>> fetchGiftList(
    @Field('giftType') String giftType, //0 全部返回, 1普通礼物 2vip礼物 3背包礼物
  );

  @POST('/api/$_appName/custom/send_gift_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> sendGift(
    @Field('anchor_id') String anchorId,
    @Field('gift_id') String giftId,
    @Field('num') String num,
    @Field('s_type') String type,
    @Field('conversation_id') String conversationId,
    @Field('is_backpack') String isBackpack, //0钻石送礼 1背包送礼
  );

  @POST('/api/$_appName/follow/follow_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveFollowModel>>> fetchFollowList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/follow/add_follow_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> addFollow(
    @Field('follow_id') String anchorId,
  );

  @POST('/api/$_appName/follow/cancel_follow_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> cancelFollow(
    @Field('follow_id') String anchorId,
  );

  @POST('/api/$_appName/follow/fans_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveFollowerModel>>> fetchFansList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/block_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveBlockModel>>> fetchBlockList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/block_user_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> addBlock(
    @Field('block_id') String anchorId,
    @Field('isRobot') String isRobot,
  );

  @POST('/api/$_appName/user/clear_block_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> cancelBlock(
    @Field('block_id') String anchorId,
    @Field('isRobot') String isRobot,
  );

  @POST('/api/$_appName/user/chat_info_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveChatBlockModel>> chatBlockInfo(
    @Field('touid') String anchorId,
  );

  @POST('/api/$_appName/user/chat_record_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> chatRecordInfo(
    @Field('touid') String anchorId,
    @Field('m_type') String type, // text '1', image '2', emoji '3'
    @Field('message') String message,
  );

  @POST('/api/$_appName/item/userBackpack_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveCardBaseModel>> fetchBackpackInfo();

  @POST('/api/$_appName/custom/custom_conversation_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveCallRecordModel>>>
      fetchCallRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/gift_exchange_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveGiftRecordModel>>>
      fetchGiftRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/exchange_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveSysRecordModel>>> fetchSysRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/order_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveTopupRecordModel>>>
      fetchTopupRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/feedback_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> feedback(
    @Field('content') String content,
    @Field('images') String images,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Home API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/user/banner_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveBannerModel>>> fetchBannerList();

  @POST('/api/$_appName/user/area_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveAreaModel>>> fetchAreaList();

  @POST('/api/$_appName/dynamic/anchor_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveAnchorModel>>> fetchAnchorList(
    @Field('area') String area,
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/user/searchAll_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> searchAnchorList(
    @Field('key') String keyword,
  );

  @POST('/api/$_appName/custom/first_login_status_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> fetchActivityStatus();

  @POST('/api/$_appName/user/giveDiamondToNewUser_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> fetchNewUserReward();

  @POST('/api/$_appName/activity/turntable_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveTurntableModel>> fetchTurntableList();

  @POST('/api/$_appName/activity/draw_turntable_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveLuskyDrawModel>> requestDrawTurntable();

  @POST('/api/$_appName/activity/turntable_record_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveTurntableRecordModel>>>
      fetchTurntableRecordList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/system/sms_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveSystemMessageModel>>>
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
  //////////////////////////////// Moment API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/dynamic/all_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> fetchMomentList(
    @Field('country') String country,
    @Field('page') String page,
    @Field('size') String size, {
    @Field('isUpdate') String update = '1',
  });

  @POST('/api/$_appName/dynamic/my_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>> fetchMyMomentList(
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/dynamic/create_$_appName')
  // @FormUrlEncoded() //1以表单得方式请求会失败
  Future<ColiveApiResponse<dynamic>> createMoment(
    @Field('content') String content,
    @Field('images') List<String> images,
  );

  @POST('/api/$_appName/dynamic/del_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> deleteMoment(
    @Field('id') String id,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Anchor API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/custom/information_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveAnchorDetailModel>> fetchAnchorInfo(
    @Field('anchor_id') String anchorId,
  );

  @POST('/api/$_appName/robot/robotInfo_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveAnchorDetailModel>> fetchRobotAnchorInfo(
    @Field('ai_id') String anchorId,
  );

  @POST('/api/$_appName/custom/visit_anchor_dynamic_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveMomentItemModel>>>
      fetchAnchorMomentList(
    @Field('anchor_id') String anchorId,
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/custom/visit_anchor_video_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveAnchorModelVideo>>>
      fetchAnchorVideoList(
    @Field('anchor_id') String anchorId,
    @Field('page') String page,
    @Field('size') String size,
  );

  @POST('/api/$_appName/robot/robotVideo_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveAnchorModelVideo>>>
      fetchRobotAnchorVideoList(
    @Field('ai_id') String anchorId,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Call API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/conversation/create_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveCallModel>> callCreate(
    @Field('anchor_id') String anchorId,
    @Field('custom_id') String userId,
    @Field('isAi') String isRobot,
  );

  @POST('/api/$_appName/conversation/refuse_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callRefuse(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/timeout_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callTimeout(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/on_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callOn(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/settlement_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callSettlement(
    @Field('conversation_id') String conversationId,
  );

  @POST('/api/$_appName/conversation/answer_ai_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callAiAnswer();

  @POST('/api/$_appName/conversation/refuse_ai_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callAiRefuse(
    @Field('anchor_id') String anchorId,
    @Field('pushType') String pushType,
    @Field('isTimeOut') String isTimeOut,
  );

  @POST('/api/$_appName/conversation/hangup_ai_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> callAiHangup(
    @Field('anchor_id') String anchorId,
    @Field('url') String url,
    @Field('isFinish') String isFinish,
  );

  /////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// Order API
  /////////////////////////////////////////////////////////////////////////////

  @POST('/api/$_appName/order/pay_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<ColiveProductBaseModel>> fetchProductList(
    @Field('type') String type, //1 diamonds, 2 vip, 3 promotions
  );

  @POST('/api/$_appName/order/pay_channel_list_$_appName')
  @FormUrlEncoded()
  Future<ColiveApiResponse<List<ColiveChannelItemModel>>> fetchChannelList(
    @Field('payId') String payId,
    @Field('country') String country,
  );

  @POST('/api/order/google_pay_notify') // Android
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> verifyOrderAndroid(
    @Field('order_token') String orderToken,
    @Field('packageName') String packageName,
    @Field('product_id') String productId,
  );

  @POST('/api/order/recharge_ios') // iOS
  @FormUrlEncoded()
  Future<ColiveApiResponse<dynamic>> verifyOrderIOS(
    @Field('receipt') String receipt,
    @Field('order_no') String orderId,
    @Field('transaction_id') String transactionId,
  );
}
