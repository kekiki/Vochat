// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:colive/services/models/colive_order_item_model.dart';
import 'package:colive/services/models/colive_search_history_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/colive_anchor_model.dart';
import '../models/colive_card_base_model.dart';
import '../models/colive_chat_conversation_model.dart';
import '../models/colive_moment_item_model.dart';
import 'converters/colive_list_album_converter.dart';
import 'converters/colive_list_string_converter.dart';
import 'converters/colive_list_tag_converter.dart';
import 'converters/colive_list_video_converter.dart';
import 'daos/colive_anchor_dao.dart';
import 'daos/colive_card_dao.dart';
import 'daos/colive_chat_conversation_dao.dart';
import 'daos/colive_moment_dao.dart';
import 'daos/colive_order_dao.dart';
import 'daos/colive_search_history_dao.dart';

part 'colive_database.g.dart';

@TypeConverters([ColiveListStringConverter])
@Database(
  version: 1,
  entities: [
    ColiveAnchorModel,
    ColiveChatConversationModel,
    ColiveOrderItemModel,
    ColiveMomentItemModel,
    ColiveSearchHistoryModel,
    ColiveCardItemModel,
  ],
)
abstract class ColiveDatabase extends FloorDatabase {
  ColiveAnchorDao get anchorDao;
  ColiveChatConversationDao get chatConversationDao;
  ColiveOrderDao get orderDao;
  ColiveMomentDao get momentDao;
  SearchHistoryDao get searchHistoryDao;
  ColiveCardDao get cardDao;
}
