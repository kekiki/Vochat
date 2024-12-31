import 'vochat_local_translations.dart';

extension VochatLanguageEnglish on VochatLocalTranslations {
  Map<String, String> get english => {
        // login
        'vochat_login_quick': 'Quick Login',
        'vochat_login_apple': 'Sign in with Apple',
        'vochat_login_google': 'Sign in with Google',
        "vochat_login_agreement": "Agree the User Agreement and Privacy Policy",
        'vochat_user_agreement': 'User Agreement',
        'vochat_privacy_policy': 'Privacy Policy',
        'vochat_information': 'Information',
        'vochat_nickname': 'Nickname',
        'vochat_birthday': 'Birthday',
        'vochat_gender': 'Gender',
        'vochat_male': 'Male',
        'vochat_female': 'Female',
        'vochat_enter': 'Enter',
        'vochat_failed': 'Failed',
        'vochat_succeeded': 'Succeed',

        // // status
        // 'vochat_online': 'Online',
        // 'vochat_busy': 'Busy',
        // 'vochat_offline': 'Offline',

        // 'vochat_no_data': 'No Data',
        // 'vochat_no_network': 'Network is unavailable',

        // // permission
        // "permission_tips": "Permission tips",
        // "permission_desc":
        //     "Allows access to the \nfollowing for a better service",

        // 'vochat_camera': 'Camera',
        // 'vochat_microphone': 'Microphone',
        // 'vochat_storage': 'Storage',
        // 'vochat_photos': 'Photos',

        // 'vochat_allow': 'Allow',
        // 'vochat_allow_all': 'Allow all',

        // //home
        // 'vochat_discover': 'Discover',
        // 'vochat_moment': 'Moment',
        // 'vochat_chat': 'Message',
        // 'vochat_mine': 'Mine',

        // 'vochat_popular': 'Popular',
        // 'vochat_follow': 'Following',
        // 'vochat_fans': 'Followers',
        // 'vochat_blacklist': 'Blacklist',
        // 'vochat_followed': 'Followed',
        // 'vochat_block': 'Block',
        // 'vochat_cancel_block': 'Cancel block',

        // 'vochat_pull_refresh': 'Pull to refresh',
        // 'vochat_pull_load': 'Pull to load',
        // 'vochat_release_ready': 'Release ready',
        // 'vochat_refreshing': 'Refreshing...',
        // 'vochat_loading': 'Loading...',
        // 'vochat_no_more_text': 'No more',

        // // Anchor detail
        // 'vochat_score': 'Score',
        // 'vochat_video': 'Video',
        // 'vochat_introduction': 'Introduction',
        // 'vochat_anchor_signature_place':
        //     'This girl is very lazy and hasn’t written anything.',
        // 'vochat_tags': 'Tags',
        // 'vochat_single': 'Single', //单身
        // "vochat_add_follow_tips": "Added following successfully", // 添加关注成功
        // "vochat_cancel_follow_tips": "Unfollowed successfully", // 取消关注成功
        // 'vochat_height': 'Height',
        // 'vochat_weight': 'Weight',
        // 'vochat_emotion': 'Emotion',

        // "vochat_religious_belief": "Religious belief", // 宗教信仰
        // "vochat_internet_violence": "Internet violence", // 网络暴力
        // "vochat_minor": "Minor", // 未成年人
        // "vochat_fraud": "Fraud", //诈骗
        // "vochat_vulgar": "Vulgar", // 低俗
        // "vochat_report": "Report",
        // "vochat_report_success": "Report Succeeded", // 举报成功

        // //chat
        // 'vochat_pin': 'Pin',
        // 'vochat_unpin': 'Unpin',
        // 'vochat_delete': 'Delete',
        // 'vochat_enter_content': 'Please enter the content',
        // "vochat_message_remain_%s_num":
        //     "You can also send %s messages", // 您还可以发送
        // 'vochat_unlimit_chat_tips': 'Open VIP to enjoy unlimited chat',
        // "vochat_chat_vip_%s_limit": "You are using your %s free messages",
        // "vochat_chat_vip_runout": "You have run out of free messages",
        // "vochat_chat_vip_tip": "Enjoy unlimited chats?",
        // "vochat_become_vip": "Become VIP",

        // 'vochat_send': 'Send',
        // 'vochat_confirm': 'Confirm',
        // 'vochat_cancel': 'Cancel',
        // 'vochat_got_it': 'Got it',
        // 'vochat_done': 'Done',
        // 'vochat_topup': 'Top-up',
        // 'vochat_gift_send_out': 'Send out',
        // 'vochat_gift_ask_for': 'She wants you to give her one',
        // 'vochat_delete_all': 'Delete all',
        // 'vochat_ignore_unread': 'Ignore unread',
        // 'vochat_quick_recharge': 'Quick recharge',
        // 'vochat_%s_days': '%s Days',

        // "vochat_add_block_tips": "Blocked successfully", // 拉黑成功
        // "vochat_cancel_block_tips": "Unblocked", // 取消拉黑成功
        // "vochat_to_block_tips": "You have blocked the girl", // 你已将对方拉黑!
        // "vochat_be_block_tips":
        //     "You have been blocked by the other party", // 你已被对方拉黑

        // "vochat_ask_gift": "Ask for a gift", // 索要礼物
        // "vochat_picture": "Picture", // 图片
        // "vochat_voice": "Voice", // 语音
        // "vochat_emoji": "Emoji", // 表情
        // "vochat_video_call": "Video Call", // 视频通话

        // "vochat_duration": "Duration", // 通话时长
        // "vochat_declined": "Declined", // 拒绝
        // "vochat_canceled": "Canceled", // 取消
        // "vochat_missed": "Missed", // 未接

        // //search
        // 'vochat_search': 'Search',
        // 'vochat_search_placeholder': 'Search ID or Nickname',
        // 'vochat_history': 'History',

        // //mine
        // 'vochat_id_num_%s': 'ID:%s',
        // 'vochat_store': 'Diamonds store',
        // 'vochat_my_balance': 'My Balance',
        // 'vochat_vip': 'VIP',
        // 'vochat_cards': 'My Cards',
        // 'vochat_bills': 'My Bills',
        // 'vochat_no_disturb': 'No Disturb Mode',
        // 'vochat_no_disturb_tips':
        //     'If you open No Disturb Mode, you will not receive any calls.',
        // 'vochat_customer_service': 'Customer Service',
        // 'vochat_settings': 'Settings',
        // 'vochat_version_%s': 'Version: %s',
        // 'vochat_choose_language': 'Choose language',
        // 'vochat_about_us': 'About us',
        // 'vochat_delete_account': 'Delete Account',
        // 'vochat_logout': 'Logout',
        // 'vochat_logout_tips':
        //     'Don\'t worry, your diamonds and transaction records will be kept.',
        // 'vochat_delete_account_tips':
        //     'All your transaction records and account balance will be erased if you delete your account. If you just need to leave the APP for now, you can choose to logout or uninstall the APP.',

        // 'vochat_edit_profile': 'Edit Profile',
        // 'vochat_id': 'ID',
        // 'vochat_signature': 'Signature',
        // "vochat_nickname_place": "Enter your nickname",
        // "vochat_signature_place": "Enter your signature",
        // 'vochat_call': 'Call',
        // 'vochat_gift': 'Gift',
        // 'vochat_sys': 'Sys',
        // 'vochat_backpack': 'Backpack',
        // 'vochat_backpack_empty': 'The backpack is empty',
        // 'vochat_diamond_recharge': 'Diamond recharge',
        // 'vochat_diamond_recharge_rewards': 'Diamond recharge rewards',
        // 'vochat_vip_recharge': 'VIP recharge',
        // 'vochat_vip_recharge_rewards': 'VIP recharge rewards',
        // "vochat_vip_notice":
        //     "Users who recharge VIP can get free video calling cards",
        // 'vochat_%s_off': '%s OFF',
        // 'vochat_system': 'System',
        // 'vochat_order_no_%s': 'Order no: %s',
        // 'vochat_lottery': 'Lottery',
        // 'vochat_remain_times_%s': 'Remaining times: %s',
        // 'vochat_no_remain_times_tips':
        //     'No lucky draw remain times, Now get lucky draw opportunities by recharging.',
        // 'vochat_lucky_draw_notice_%s_%s': '%s just won %s',
        // 'vochat_records': 'Records',
        // 'vochat_rule': 'Rule',
        // 'vochat_rule_text1':
        //     '1. Users can get lucky draw opportunities by recharging.',
        // 'vochat_rule_text2':
        //     '2. Randomly obtain diamonds, video call coupons, discount coupons, gifts, and VIP rewards.',
        // 'vochat_rule_text3':
        //     '3. The application reserves all rights of final interpretation.',
        // 'vochat_rule_text4_%s':
        //     '4. Disclaimer: This event is not jointly conducted with %s.',

        // //call
        // 'vochat_call_price_%s_min': '%s/min',
        // 'vochat_not_enough_diamods': 'Not enough diamonds',
        // 'vochat_anchor_busy': 'The girl is busy, please try again later',
        // 'vochat_anchor_offline': 'The girl is offline, please try again later',
        // 'vochat_call_failed': 'Call failed, Please check your network',
        // 'vochat_send_call_waiting': 'Waiting...',
        // 'vochat_call_connecting': 'Connecting...',
        // 'vochat_receive_call_waiting': 'You have a new call...',
        // "vochat_call_hangup_tips":
        //     "Are you sure you want to hang up on this call?",

        // 'vochat_call_duration': 'Call Duration',
        // 'vochat_call_cost': 'Call Cost',
        // 'vochat_card_cost': 'Card Cost',
        // 'vochat_gift_cost': 'Gift Cost',
        // 'vochat_rate_tips': 'Like her or not?',

        // // payment
        // 'vochat_iap_unsusport': 'In app purchase not available',
        // 'vochat_have_unfinished_order': 'There is an unfinished order',
        // 'vochat_invilid_product': 'Invilid product',
        // 'vochat_failed': 'Failed',
        // 'vochat_succeeded': 'Succeeded',
        // 'vochat_delay_tips':
        //     'Recharge successfully, there may be a few seconds delay.',
        // 'vochat_payment_method': 'Payment Method',
        // 'vochat_free': 'Free',
        // 'vochat_limited_time_offer': 'Limited Time Offer',

        // // moment
        // 'vochat_post': 'Post',
        // 'vochat_hot': 'Hot',
        // 'vochat_post_placeholder':
        //     'Record this moment and share it with people who understand you...',
        // 'vochat_delete_tips': 'Are you sure you want to delete it',

        // // other
        // 'vochat_system_message': 'System Message',
        // 'vochat_system_message_default_title_%s': 'Welcome to %s~',
        // 'vochat_system_message_default_content':
        //     'We hope you have the best time here.',

        // // VIP
        // 'vochat_privilege_call_text': 'Enjoy Free video calls',
        // 'vochat_privilege_call_desc': 'Get extra cards for Free video call',
        // 'vochat_privilege_chat_text': 'Chat freely with friends',
        // 'vochat_privilege_chat_desc': 'Send messages without limitation',
        // 'vochat_privilege_diamond_text': 'Get extra diamonds',
        // 'vochat_privilege_diamond_desc': 'Recharge VIP can get extra diamonds',
        // 'vochat_privilege_video_text': 'Unlock private videos',
        // 'vochat_privilege_video_desc':
        //     'Unlimited viewing of user private videos',
        // 'vochat_privilege_photo_text': 'Unlock private photos',
        // 'vochat_privilege_photo_desc':
        //     'Unlimited viewing of user private photos',
      };
}
