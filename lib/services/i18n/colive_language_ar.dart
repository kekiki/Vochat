import 'colive_local_translations.dart';

extension ColiveLanguageArabic on ColiveLocalTranslations {
  Map<String, String> get arabic => {
        // login
        'colive_login_failed': 'فشل تسجيل الدخول',
        'colive_request_failed': 'فشل الطلب',
        "colive_login_accept": "عن طريق تسجيل الدخول فإنك تقبل لدينا",
        "colive_and": "و",
        'colive_privacy_policy': 'سياسة الخصوصية',
        'colive_term_of_service': 'مدة الخدمة',
        'colive_login_quick': 'تسجيل الدخول السريع',
        'colive_login_apple': 'تسجيل الدخول مع أبل',
        'colive_login_google': 'تسجيل الدخول باستخدام جوجل',

        // status
        'colive_online': 'متصل',
        'colive_busy': 'مشغول',
        'colive_offline': 'غير متصل',

        'colive_no_data': 'لا يوجد بيانات',
        'colive_no_network': 'الشبكة غير متاحة',

        // permission
        "permission_tips": "نصائح الأذونات",
        "permission_desc": "يسمح بالوصول إلى ما يلي للحصول على خدمة أفضل",

        'colive_camera': 'آلة تصوير',
        'colive_microphone': 'ميكروفون',
        'colive_storage': 'تخزين',
        'colive_photos': 'الصور',

        'colive_allow': 'يسمح',
        'colive_allow_all': 'السماح للجميع',

        //home
        'colive_discover': 'يكتشف',
        'colive_moment': 'لحظة',
        'colive_chat': 'رسالة',
        'colive_mine': 'مِلكِي',

        'colive_popular': 'شائع',
        'colive_follow': 'اتبعت',
        'colive_fans': 'معجبيني',
        'colive_blacklist': 'قائمة سوداء',
        'colive_followed': 'متابعة بالفعل',
        'colive_block': 'حاجز',
        'colive_cancel_block': 'إلغاء الكتلة',

        'colive_pull_refresh': 'اسحب للتحديث',
        'colive_pull_load': 'سحب للتحميل',
        'colive_release_ready': 'الافراج جاهز',
        'colive_refreshing': 'منعش...',
        'colive_loading': 'جاري التحميل...',
        'colive_no_more_text': 'لا أكثر',

        // Anchor detail
        'colive_score': 'نتيجة',
        'colive_video': 'فيديو',
        'colive_introduction': 'مقدمة',
        'colive_anchor_signature_place': 'هذه الفتاة كسولة ولم تكتب أي شيء',
        'colive_tags': 'العلامات',
        'colive_single': 'أعزب', //单身
        "colive_add_follow_tips": "اشترك بنجاح", // 添加关注成功
        "colive_cancel_follow_tips": "إلغاء الاشتراك", // 取消关注成功
        'colive_height': 'ارتفاع',
        'colive_weight': 'وزن',
        'colive_emotion': 'العاطفة',

        "colive_religious_belief": "المعتقد الديني", // 宗教信仰
        "colive_internet_violence": "العنف على الإنترنت", // 网络暴力
        "colive_minor": "صغير", // 未成年人
        "colive_fraud": "احتيال", //诈骗
        "colive_vulgar": "المبتذلة", // 低俗
        "colive_report": "تقرير",
        "colive_report_success": "تم الإبلاغ بنجاح", // 举报成功

        //chat
        'colive_pin': 'دبوس',
        'colive_unpin': 'يلغي',
        'colive_delete': 'حذف',
        'colive_enter_content': 'الرجاء إدخال المحتوى',
        "colive_message_remain_%s_num": "يمكنك أيضًا إرسال %s رسائل", // 您还可以发送
        'colive_unlimit_chat_tips': 'افتح VIP للاستمتاع بالدردشة غير المحدودة',
        "colive_chat_vip_%s_limit": "أنت تعيد استخدام %s رسائل مجانية لشخص ما",
        "colive_chat_vip_runout": "لديك نفاد الرسائل المجانية",
        "colive_chat_vip_tip": "استمتع بالدردشة غير المحدودة؟",
        "colive_become_vip": "تصبح VIP",

        'colive_send': 'يرسل',
        'colive_confirm': 'نعم',
        'colive_cancel': 'يلغي',
        'colive_got_it': 'فهمتها',
        'colive_done': 'منتهي',
        'colive_topup': 'أعلى حتى',
        'colive_gift_send_out': 'ترسل',
        'colive_gift_ask_for': 'إنها تريد منك أن تعطيها هدية',
        'colive_delete_all': 'حذف الكل',
        'colive_ignore_unread': 'تجاهل غير مقروءة',
        'colive_quick_recharge': 'إعادة شحن سريعة',
        'colive_%s_days': '%s أيام',

        "colive_add_block_tips": "تم حظره بنجاح", // 拉黑成功
        "colive_cancel_block_tips": "غير محظور", // 取消拉黑成功
        "colive_to_block_tips": "لقد تم حظر هذه الفتاة", // 你已将对方拉黑!
        "colive_be_block_tips": "لقد تم حظره من قبل هذه الفتاة", // 你已被对方拉黑

        "colive_ask_gift": "اطلب الهدية", // 索要礼物
        "colive_picture": "صورة", // 图片
        "colive_voice": "صوت", // 语音
        "colive_emoji": "مستوى الايمو", // 表情
        "colive_video_call": "مكالمة فيديو", // 视频通话

        "colive_duration": "مدة", // 通话时长
        "colive_declined": "رفض", // 拒绝
        "colive_canceled": "ألغيت ألغيت", // 取消
        "colive_missed": "مٌفتَقد", // 未接

        //search
        'colive_search': 'يبحث',
        'colive_search_placeholder': 'معرف البحث أو اللقب',
        'colive_history': 'تاريخ',

        //mine
        'colive_id_num_%s': 'معرف:%s',
        'colive_store': 'متجر الماس',
        'colive_my_balance': 'بلدي الرصيد',
        'colive_vip': 'VIP',
        'colive_cards': 'بطاقاتي',
        'colive_bills': 'فواتيري',
        'colive_no_disturb': 'وضع عدم الإزعاج',
        'colive_no_disturb_tips':
            'إذا قمت بفتح وضع عدم الإزعاج، فلن تتلقى أي مكالمات.',
        'colive_customer_service': 'خدمة العملاء',
        'colive_settings': 'إعدادات',
        'colive_version_%s': 'الإصدار: %s',
        'colive_choose_language': 'اختر اللغة',
        'colive_about_us': 'معلومات عنا',
        'colive_delete_account': 'حذف الحساب',
        'colive_logout': 'تسجيل الخروج',
        'colive_logout_tips':
            'لا تقلق كثيرًا، سيتم الاحتفاظ بسجلات الماس والمعاملات الخاصة بك.',
        'colive_delete_account_tips':
            'سيتم مسح جميع سجلات معاملاتك ورصيد حسابك إذا قمت بحذف حسابك. إذا كنت بحاجة فقط إلى مغادرة التطبيق في الوقت الحالي، فيمكنك اختيار تسجيل الخروج أو إلغاء تثبيت التطبيق.',

        'colive_edit_profile': 'تحرير الملف الشخصي',
        'colive_id': 'معرف',
        'colive_nickname': 'كنية',
        'colive_signature': 'مقدمة',
        'colive_birthday': 'عيد ميلاد',
        "colive_nickname_place": "أدخل لقبك",
        "colive_signature_place": "أدخل مقدمة نفسك",
        'colive_call': 'يتصل',
        'colive_gift': 'هدية',
        'colive_sys': 'نظام',
        'colive_backpack': 'حقيبة الظهر',
        'colive_backpack_empty': 'حقيبة الظهر فارغة',
        'colive_diamond_recharge': 'إعادة شحن الماس',
        'colive_diamond_recharge_rewards': 'مكافآت شحن الماس',
        'colive_vip_recharge': 'إعادة شحن VIP',
        'colive_vip_recharge_rewards': 'مكافآت إعادة شحن VIP',
        "colive_vip_notice":
            "يمكن للمستخدمين الذين يقومون بإعادة شحن VIP الحصول على كوبونات مكالمات الفيديو",
        'colive_%s_off': 'خصم %s',
        'colive_system': 'نظام',
        'colive_order_no_%s': 'رقم الأمر: %s',
        'colive_lottery': 'اليانصيب',
        'colive_remain_times_%s': 'الأوقات المتبقية: %s',
        'colive_no_remain_times_tips':
            'لا توجد أوقات اليانصيب ماذا عن إعادة الشحن الآن للحصول عليه؟',
        'colive_lucky_draw_notice_%s_%s': '%s حصل على %s',
        'colive_records': 'السجلات',
        'colive_rule': 'القاعدة',
        'colive_rule_text1':
            '1. يحصل مسح المستخدم على فرص السحب المحظوظ من خلال إعادة الشحن؛',
        'colive_rule_text2':
            '2. احصل بشكل عشوائي على الماسات وكوبونات مكالمات الفيديو وكوبونات الخصم والهدايا ومكافآت VIP؛',
        'colive_rule_text3': '3. يحتفظ التطبيق بجميع حقوق التفسير النهائي.',
        'colive_rule_text4_%s':
            '4. إخلاء المسؤولية: لم يتم إجراء هذا الحدث بالاشتراك مع شركة %s.',

        //call
        'colive_call_price_%s_min': '%s/دقيقة',
        'colive_not_enough_diamods': 'ليس ما يكفي من الماس',
        'colive_anchor_busy':
            'هذه الفتاة مشغولة، يرجى المحاولة مرة أخرى في وقت لاحق',
        'colive_anchor_offline':
            'هذه الفتاة غير متصلة بالإنترنت، يرجى المحاولة مرة أخرى لاحقاً',
        'colive_call_failed': 'فشل الاتصال، يرجى التحقق من توفر الشبكة',
        'colive_send_call_waiting': 'انتظار...',
        'colive_call_connecting': 'ربط...',
        'colive_receive_call_waiting': 'لديك مكالمة جديدة...',
        "colive_call_hangup_tips": "هل أنت متأكد وتريد تعليق هذه المكالمة؟",

        'colive_call_duration': 'مدة المكالمة',
        'colive_call_cost': 'تكلفة المكالمة',
        'colive_card_cost': 'تكاليف البطاقة',
        'colive_gift_cost': 'تكلفة الهدية',
        'colive_rate_tips': 'هل تحبها؟',

        // payment
        'colive_iap_unsusport': 'شراء التطبيق غير متوفر',
        'colive_have_unfinished_order': 'هناك أمر المعلقة',
        'colive_invilid_product': 'منتج غير صالح',
        'colive_failed': 'فشل',
        'colive_succeeded': 'نجاح',
        'colive_delay_tips': 'تم الشحن بنجاح، قد يكون هناك تأخير لبضع ثوان.',
        'colive_payment_method': 'وسيلة الدفع',
        'colive_free': 'مجانا',
        'colive_limited_time_offer': 'عرض لفترة محدودة',

        // moment
        'colive_post': 'بريد',
        'colive_hot': 'حار',
        'colive_post_placeholder':
            'سجل هذه اللحظة وشاركها مع الأشخاص الذين يفهمونك...',
        'colive_delete_tips': 'هل أنت متأكد أنك تريد حذفه؟',

        // other
        'colive_system_message': 'رسالة النظام',
        'colive_system_message_default_title_%s': 'مرحباً بكم في %s~',
        'colive_system_message_default_content':
            'نأمل أن يكون لديك أفضل الأوقات هنا.',

        // VIP
        'colive_privilege_call_text': 'تتمتع مكالمات الفيديو مجانا',
        'colive_privilege_call_desc':
            'بطاقة إضافية للحصول على مكالمات الفيديو مجانا',
        'colive_privilege_chat_text': 'مجانا دردشة مع الأصدقاء',
        'colive_privilege_chat_desc': 'إرسال رسالة غير مقيد',
        'colive_privilege_diamond_text': 'الحصول على المزيد من الماس',
        'colive_privilege_diamond_desc':
            'شحن كبار الشخصيات يمكن الحصول على الماس إضافية',
        'colive_privilege_video_text': 'فتح الفيديو الخاص',
        'colive_privilege_video_desc':
            'لا قيود على عرض الفيديو الخاص للمستخدمين',
        'colive_privilege_photo_text': 'فتح الصور الخاصة',
        'colive_privilege_photo_desc': 'غير محدود عرض الصور الخاصة للمستخدمين',
      };
}
