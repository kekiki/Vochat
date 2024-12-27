import 'colive_local_translations.dart';

extension ColiveLanguageEnglish on ColiveLocalTranslations {
  Map<String, String> get english => {
        // login
        'colive_login_failed': 'Login failed',
        'colive_request_failed': 'Request failed',
        "colive_login_accept": "By logging in you accept our",
        "colive_and": "and",
        'colive_privacy_policy': 'Privacy policy',
        'colive_term_of_service': 'Term of service',
        'colive_login_quick': 'Quick Login',
        'colive_login_apple': 'Sign in with Apple',
        'colive_login_google': 'Sign in with Google',

        // status
        'colive_online': 'Online',
        'colive_busy': 'Busy',
        'colive_offline': 'Offline',

        'colive_no_data': 'No Data',
        'colive_no_network': 'Network is unavailable',

        // permission
        "permission_tips": "Permission tips",
        "permission_desc":
            "Allows access to the \nfollowing for a better service",

        'colive_camera': 'Camera',
        'colive_microphone': 'Microphone',
        'colive_storage': 'Storage',
        'colive_photos': 'Photos',

        'colive_allow': 'Allow',
        'colive_allow_all': 'Allow all',

        //home
        'colive_discover': 'Discover',
        'colive_moment': 'Moment',
        'colive_chat': 'Message',
        'colive_mine': 'Mine',

        'colive_popular': 'Popular',
        'colive_follow': 'Following',
        'colive_fans': 'Followers',
        'colive_blacklist': 'Blacklist',
        'colive_followed': 'Followed',
        'colive_block': 'Block',
        'colive_cancel_block': 'Cancel block',

        'colive_pull_refresh': 'Pull to refresh',
        'colive_pull_load': 'Pull to load',
        'colive_release_ready': 'Release ready',
        'colive_refreshing': 'Refreshing...',
        'colive_loading': 'Loading...',
        'colive_no_more_text': 'No more',

        // Anchor detail
        'colive_score': 'Score',
        'colive_video': 'Video',
        'colive_introduction': 'Introduction',
        'colive_anchor_signature_place':
            'This girl is very lazy and hasn’t written anything.',
        'colive_tags': 'Tags',
        'colive_single': 'Single', //单身
        "colive_add_follow_tips": "Added following successfully", // 添加关注成功
        "colive_cancel_follow_tips": "Unfollowed successfully", // 取消关注成功
        'colive_height': 'Height',
        'colive_weight': 'Weight',
        'colive_emotion': 'Emotion',

        "colive_religious_belief": "Religious belief", // 宗教信仰
        "colive_internet_violence": "Internet violence", // 网络暴力
        "colive_minor": "Minor", // 未成年人
        "colive_fraud": "Fraud", //诈骗
        "colive_vulgar": "Vulgar", // 低俗
        "colive_report": "Report",
        "colive_report_success": "Report Succeeded", // 举报成功

        //chat
        'colive_pin': 'Pin',
        'colive_unpin': 'Unpin',
        'colive_delete': 'Delete',
        'colive_enter_content': 'Please enter the content',
        "colive_message_remain_%s_num":
            "You can also send %s messages", // 您还可以发送
        'colive_unlimit_chat_tips': 'Open VIP to enjoy unlimited chat',
        "colive_chat_vip_%s_limit": "You are using your %s free messages",
        "colive_chat_vip_runout": "You have run out of free messages",
        "colive_chat_vip_tip": "Enjoy unlimited chats?",
        "colive_become_vip": "Become VIP",

        'colive_send': 'Send',
        'colive_confirm': 'Confirm',
        'colive_cancel': 'Cancel',
        'colive_got_it': 'Got it',
        'colive_done': 'Done',
        'colive_topup': 'Top-up',
        'colive_gift_send_out': 'Send out',
        'colive_gift_ask_for': 'She wants you to give her one',
        'colive_delete_all': 'Delete all',
        'colive_ignore_unread': 'Ignore unread',
        'colive_quick_recharge': 'Quick recharge',
        'colive_%s_days': '%s Days',

        "colive_add_block_tips": "Blocked successfully", // 拉黑成功
        "colive_cancel_block_tips": "Unblocked", // 取消拉黑成功
        "colive_to_block_tips": "You have blocked the girl", // 你已将对方拉黑!
        "colive_be_block_tips":
            "You have been blocked by the other party", // 你已被对方拉黑

        "colive_ask_gift": "Ask for a gift", // 索要礼物
        "colive_picture": "Picture", // 图片
        "colive_voice": "Voice", // 语音
        "colive_emoji": "Emoji", // 表情
        "colive_video_call": "Video Call", // 视频通话

        "colive_duration": "Duration", // 通话时长
        "colive_declined": "Declined", // 拒绝
        "colive_canceled": "Canceled", // 取消
        "colive_missed": "Missed", // 未接

        //search
        'colive_search': 'Search',
        'colive_search_placeholder': 'Search ID or Nickname',
        'colive_history': 'History',

        //mine
        'colive_id_num_%s': 'ID:%s',
        'colive_store': 'Diamonds store',
        'colive_my_balance': 'My Balance',
        'colive_vip': 'VIP',
        'colive_cards': 'My Cards',
        'colive_bills': 'My Bills',
        'colive_no_disturb': 'No Disturb Mode',
        'colive_no_disturb_tips':
            'If you open No Disturb Mode, you will not receive any calls.',
        'colive_customer_service': 'Customer Service',
        'colive_settings': 'Settings',
        'colive_version_%s': 'Version: %s',
        'colive_choose_language': 'Choose language',
        'colive_about_us': 'About us',
        'colive_delete_account': 'Delete Account',
        'colive_logout': 'Logout',
        'colive_logout_tips':
            'Don\'t worry, your diamonds and transaction records will be kept.',
        'colive_delete_account_tips':
            'All your transaction records and account balance will be erased if you delete your account. If you just need to leave the APP for now, you can choose to logout or uninstall the APP.',

        'colive_edit_profile': 'Edit Profile',
        'colive_id': 'ID',
        'colive_nickname': 'Nickname',
        'colive_signature': 'Signature',
        'colive_birthday': 'Birthday',
        "colive_nickname_place": "Enter your nickname",
        "colive_signature_place": "Enter your signature",
        'colive_call': 'Call',
        'colive_gift': 'Gift',
        'colive_sys': 'Sys',
        'colive_backpack': 'Backpack',
        'colive_backpack_empty': 'The backpack is empty',
        'colive_diamond_recharge': 'Diamond recharge',
        'colive_diamond_recharge_rewards': 'Diamond recharge rewards',
        'colive_vip_recharge': 'VIP recharge',
        'colive_vip_recharge_rewards': 'VIP recharge rewards',
        "colive_vip_notice":
            "Users who recharge VIP can get free video calling cards",
        'colive_%s_off': '%s OFF',
        'colive_system': 'System',
        'colive_order_no_%s': 'Order no: %s',
        'colive_lottery': 'Lottery',
        'colive_remain_times_%s': 'Remaining times: %s',
        'colive_no_remain_times_tips':
            'No lucky draw remain times, Now get lucky draw opportunities by recharging.',
        'colive_lucky_draw_notice_%s_%s': '%s just won %s',
        'colive_records': 'Records',
        'colive_rule': 'Rule',
        'colive_rule_text1':
            '1. Users can get lucky draw opportunities by recharging.',
        'colive_rule_text2':
            '2. Randomly obtain diamonds, video call coupons, discount coupons, gifts, and VIP rewards.',
        'colive_rule_text3':
            '3. The application reserves all rights of final interpretation.',
        'colive_rule_text4_%s':
            '4. Disclaimer: This event is not jointly conducted with %s.',

        //call
        'colive_call_price_%s_min': '%s/min',
        'colive_not_enough_diamods': 'Not enough diamonds',
        'colive_anchor_busy': 'The girl is busy, please try again later',
        'colive_anchor_offline': 'The girl is offline, please try again later',
        'colive_call_failed': 'Call failed, Please check your network',
        'colive_send_call_waiting': 'Waiting...',
        'colive_call_connecting': 'Connecting...',
        'colive_receive_call_waiting': 'You have a new call...',
        "colive_call_hangup_tips":
            "Are you sure you want to hang up on this call?",

        'colive_call_duration': 'Call Duration',
        'colive_call_cost': 'Call Cost',
        'colive_card_cost': 'Card Cost',
        'colive_gift_cost': 'Gift Cost',
        'colive_rate_tips': 'Like her or not?',

        // payment
        'colive_iap_unsusport': 'In app purchase not available',
        'colive_have_unfinished_order': 'There is an unfinished order',
        'colive_invilid_product': 'Invilid product',
        'colive_failed': 'Failed',
        'colive_succeeded': 'Succeeded',
        'colive_delay_tips':
            'Recharge successfully, there may be a few seconds delay.',
        'colive_payment_method': 'Payment Method',
        'colive_free': 'Free',
        'colive_limited_time_offer': 'Limited Time Offer',

        // moment
        'colive_post': 'Post',
        'colive_hot': 'Hot',
        'colive_post_placeholder':
            'Record this moment and share it with people who understand you...',
        'colive_delete_tips': 'Are you sure you want to delete it',

        // other
        'colive_system_message': 'System Message',
        'colive_system_message_default_title_%s': 'Welcome to %s~',
        'colive_system_message_default_content':
            'We hope you have the best time here.',

        // VIP
        'colive_privilege_call_text': 'Enjoy Free video calls',
        'colive_privilege_call_desc': 'Get extra cards for Free video call',
        'colive_privilege_chat_text': 'Chat freely with friends',
        'colive_privilege_chat_desc': 'Send messages without limitation',
        'colive_privilege_diamond_text': 'Get extra diamonds',
        'colive_privilege_diamond_desc': 'Recharge VIP can get extra diamonds',
        'colive_privilege_video_text': 'Unlock private videos',
        'colive_privilege_video_desc':
            'Unlimited viewing of user private videos',
        'colive_privilege_photo_text': 'Unlock private photos',
        'colive_privilege_photo_desc':
            'Unlimited viewing of user private photos',
      };
}
