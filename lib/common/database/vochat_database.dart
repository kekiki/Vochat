// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:vochat/services/models/vochat_order_item_model.dart';
import 'package:vochat/services/models/vochat_search_history_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../services/models/vochat_anchor_model.dart';
import '../../services/models/vochat_card_base_model.dart';
import '../../services/models/vochat_chat_conversation_model.dart';
import 'converters/vochat_list_album_converter.dart';
import 'converters/vochat_list_string_converter.dart';
import 'converters/vochat_list_tag_converter.dart';
import 'converters/vochat_list_video_converter.dart';
import 'daos/vochat_anchor_dao.dart';
import 'daos/vochat_card_dao.dart';
import 'daos/vochat_chat_conversation_dao.dart';
import 'daos/vochat_order_dao.dart';
import 'daos/vochat_search_history_dao.dart';

part 'vochat_database.g.dart';

@TypeConverters([VochatListStringConverter])
@Database(
  version: 1,
  entities: [
    VochatAnchorModel,
    VochatChatConversationModel,
    VochatOrderItemModel,
    VochatSearchHistoryModel,
    VochatCardItemModel,
  ],
)
abstract class VochatDatabase extends FloorDatabase {
  VochatAnchorDao get anchorDao;
  VochatChatConversationDao get chatConversationDao;
  VochatOrderDao get orderDao;
  SearchHistoryDao get searchHistoryDao;
  VochatCardDao get cardDao;
}
