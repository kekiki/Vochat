// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ColiveDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ColiveDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ColiveDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ColiveDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorColiveDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ColiveDatabaseBuilderContract databaseBuilder(String name) =>
      _$ColiveDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ColiveDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ColiveDatabaseBuilder(null);
}

class _$ColiveDatabaseBuilder implements $ColiveDatabaseBuilderContract {
  _$ColiveDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ColiveDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ColiveDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ColiveDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ColiveDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ColiveDatabase extends ColiveDatabase {
  _$ColiveDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ColiveAnchorDao? _anchorDaoInstance;

  ColiveChatConversationDao? _chatConversationDaoInstance;

  ColiveOrderDao? _orderDaoInstance;

  ColiveMomentDao? _momentDaoInstance;

  SearchHistoryDao? _searchHistoryDaoInstance;

  ColiveCardDao? _cardDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_anchor_info` (`id` INTEGER NOT NULL, `nickname` TEXT NOT NULL, `app` TEXT NOT NULL, `area` TEXT NOT NULL, `avatar` TEXT NOT NULL, `birthday` INTEGER NOT NULL, `channel` TEXT NOT NULL, `conversationPrice` TEXT NOT NULL, `country` TEXT NOT NULL, `countryCurrency` TEXT NOT NULL, `countryIcon` TEXT NOT NULL, `diamonds` TEXT NOT NULL, `disturb` TEXT NOT NULL, `gender` TEXT NOT NULL, `gold` INTEGER NOT NULL, `robot` INTEGER NOT NULL, `lv` INTEGER NOT NULL, `online` INTEGER NOT NULL, `signature` TEXT NOT NULL, `sys` TEXT NOT NULL, `weight` INTEGER NOT NULL, `album` TEXT NOT NULL, `videos` TEXT NOT NULL, `isGreet` INTEGER NOT NULL, `label` TEXT NOT NULL, `star` TEXT NOT NULL, `height` INTEGER NOT NULL, `emotion` TEXT NOT NULL, `like` INTEGER NOT NULL, `isLike` INTEGER NOT NULL, `chatNum` INTEGER NOT NULL, `isToBlock` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_chat_conversation` (`id` TEXT NOT NULL, `avatar` TEXT, `username` TEXT, `summary` TEXT, `timestamp` INTEGER NOT NULL, `unreadCount` INTEGER NOT NULL, `orderBy` INTEGER NOT NULL, `pin` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_order_info` (`app` TEXT NOT NULL, `area` TEXT NOT NULL, `cType` INTEGER NOT NULL, `channel` TEXT NOT NULL, `channelId` INTEGER NOT NULL, `createTime` INTEGER NOT NULL, `currency` TEXT NOT NULL, `extraNum` INTEGER NOT NULL, `extraTime` INTEGER NOT NULL, `goodsId` INTEGER NOT NULL, `productId` TEXT NOT NULL, `id` INTEGER NOT NULL, `localPrice` TEXT NOT NULL, `num` INTEGER NOT NULL, `orderNo` TEXT NOT NULL, `pType` INTEGER NOT NULL, `payCountry` TEXT NOT NULL, `price` TEXT NOT NULL, `status` INTEGER NOT NULL, `type` INTEGER NOT NULL, `uid` INTEGER NOT NULL, `version` TEXT NOT NULL, `url` TEXT NOT NULL, PRIMARY KEY (`productId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_moment_info` (`id` INTEGER NOT NULL, `area` TEXT NOT NULL, `avatar` TEXT NOT NULL, `birthday` INTEGER NOT NULL, `content` TEXT NOT NULL, `conversationPrice` TEXT NOT NULL, `country` TEXT NOT NULL, `countryCurrency` TEXT NOT NULL, `countryIcon` TEXT NOT NULL, `createTime` INTEGER NOT NULL, `images` TEXT NOT NULL, `robot` INTEGER NOT NULL, `like` INTEGER NOT NULL, `likeNum` INTEGER NOT NULL, `nickname` TEXT NOT NULL, `online` INTEGER NOT NULL, `robotArea` TEXT NOT NULL, `robotAvatar` TEXT NOT NULL, `robotBirthday` INTEGER NOT NULL, `robotCountry` TEXT NOT NULL, `robotNickname` TEXT NOT NULL, `status` TEXT NOT NULL, `type` TEXT NOT NULL, `uid` INTEGER NOT NULL, `updateTime` INTEGER NOT NULL, `userArea` TEXT NOT NULL, `isLike` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_search_history` (`history` TEXT NOT NULL, `time` INTEGER NOT NULL, PRIMARY KEY (`history`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `database_table_cards` (`id` INTEGER NOT NULL, `desc` TEXT NOT NULL, `expireTime` INTEGER NOT NULL, `ext` TEXT NOT NULL, `icon` TEXT NOT NULL, `img` TEXT NOT NULL, `itemId` INTEGER NOT NULL, `itemType` INTEGER NOT NULL, `name` TEXT NOT NULL, `num` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ColiveAnchorDao get anchorDao {
    return _anchorDaoInstance ??= _$ColiveAnchorDao(database, changeListener);
  }

  @override
  ColiveChatConversationDao get chatConversationDao {
    return _chatConversationDaoInstance ??=
        _$ColiveChatConversationDao(database, changeListener);
  }

  @override
  ColiveOrderDao get orderDao {
    return _orderDaoInstance ??= _$ColiveOrderDao(database, changeListener);
  }

  @override
  ColiveMomentDao get momentDao {
    return _momentDaoInstance ??= _$ColiveMomentDao(database, changeListener);
  }

  @override
  SearchHistoryDao get searchHistoryDao {
    return _searchHistoryDaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }

  @override
  ColiveCardDao get cardDao {
    return _cardDaoInstance ??= _$ColiveCardDao(database, changeListener);
  }
}

class _$ColiveAnchorDao extends ColiveAnchorDao {
  _$ColiveAnchorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coliveAnchorModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_anchor_info',
            (ColiveAnchorModel item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'app': item.app,
                  'area': item.area,
                  'avatar': item.avatar,
                  'birthday': item.birthday,
                  'channel': item.channel,
                  'conversationPrice': item.conversationPrice,
                  'country': item.country,
                  'countryCurrency': item.countryCurrency,
                  'countryIcon': item.countryIcon,
                  'diamonds': item.diamonds,
                  'disturb': item.disturb,
                  'gender': item.gender,
                  'gold': item.gold,
                  'robot': item.robot,
                  'lv': item.lv,
                  'online': item.online,
                  'signature': item.signature,
                  'sys': item.sys,
                  'weight': item.weight,
                  'album': _coliveListAlbumConverter.encode(item.album),
                  'videos': _coliveListVideoConverter.encode(item.videos),
                  'isGreet': item.isGreet,
                  'label': _coliveListTagConverter.encode(item.label),
                  'star': item.star,
                  'height': item.height,
                  'emotion': item.emotion,
                  'like': item.like,
                  'isLike': item.isLike ? 1 : 0,
                  'chatNum': item.chatNum,
                  'isToBlock': item.isToBlock ? 1 : 0
                },
            changeListener),
        _coliveAnchorModelUpdateAdapter = UpdateAdapter(
            database,
            'database_table_anchor_info',
            ['id'],
            (ColiveAnchorModel item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'app': item.app,
                  'area': item.area,
                  'avatar': item.avatar,
                  'birthday': item.birthday,
                  'channel': item.channel,
                  'conversationPrice': item.conversationPrice,
                  'country': item.country,
                  'countryCurrency': item.countryCurrency,
                  'countryIcon': item.countryIcon,
                  'diamonds': item.diamonds,
                  'disturb': item.disturb,
                  'gender': item.gender,
                  'gold': item.gold,
                  'robot': item.robot,
                  'lv': item.lv,
                  'online': item.online,
                  'signature': item.signature,
                  'sys': item.sys,
                  'weight': item.weight,
                  'album': _coliveListAlbumConverter.encode(item.album),
                  'videos': _coliveListVideoConverter.encode(item.videos),
                  'isGreet': item.isGreet,
                  'label': _coliveListTagConverter.encode(item.label),
                  'star': item.star,
                  'height': item.height,
                  'emotion': item.emotion,
                  'like': item.like,
                  'isLike': item.isLike ? 1 : 0,
                  'chatNum': item.chatNum,
                  'isToBlock': item.isToBlock ? 1 : 0
                },
            changeListener),
        _coliveAnchorModelDeletionAdapter = DeletionAdapter(
            database,
            'database_table_anchor_info',
            ['id'],
            (ColiveAnchorModel item) => <String, Object?>{
                  'id': item.id,
                  'nickname': item.nickname,
                  'app': item.app,
                  'area': item.area,
                  'avatar': item.avatar,
                  'birthday': item.birthday,
                  'channel': item.channel,
                  'conversationPrice': item.conversationPrice,
                  'country': item.country,
                  'countryCurrency': item.countryCurrency,
                  'countryIcon': item.countryIcon,
                  'diamonds': item.diamonds,
                  'disturb': item.disturb,
                  'gender': item.gender,
                  'gold': item.gold,
                  'robot': item.robot,
                  'lv': item.lv,
                  'online': item.online,
                  'signature': item.signature,
                  'sys': item.sys,
                  'weight': item.weight,
                  'album': _coliveListAlbumConverter.encode(item.album),
                  'videos': _coliveListVideoConverter.encode(item.videos),
                  'isGreet': item.isGreet,
                  'label': _coliveListTagConverter.encode(item.label),
                  'star': item.star,
                  'height': item.height,
                  'emotion': item.emotion,
                  'like': item.like,
                  'isLike': item.isLike ? 1 : 0,
                  'chatNum': item.chatNum,
                  'isToBlock': item.isToBlock ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveAnchorModel> _coliveAnchorModelInsertionAdapter;

  final UpdateAdapter<ColiveAnchorModel> _coliveAnchorModelUpdateAdapter;

  final DeletionAdapter<ColiveAnchorModel> _coliveAnchorModelDeletionAdapter;

  @override
  Future<List<ColiveAnchorModel>> getAllAnchors() async {
    return _queryAdapter.queryList('SELECT * FROM database_table_anchor_info',
        mapper: (Map<String, Object?> row) => ColiveAnchorModel(
            row['app'] as String,
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['channel'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['diamonds'] as String,
            row['disturb'] as String,
            row['gender'] as String,
            row['gold'] as int,
            row['id'] as int,
            row['robot'] as int,
            row['lv'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['signature'] as String,
            row['sys'] as String,
            row['weight'] as int,
            _coliveListAlbumConverter.decode(row['album'] as String),
            _coliveListVideoConverter.decode(row['videos'] as String),
            row['isGreet'] as int,
            _coliveListTagConverter.decode(row['label'] as String),
            row['star'] as String,
            row['height'] as int,
            row['emotion'] as String,
            row['like'] as int,
            (row['isLike'] as int) != 0,
            row['chatNum'] as int,
            (row['isToBlock'] as int) != 0));
  }

  @override
  Stream<List<ColiveAnchorModel>> getFollowAnchorsAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM database_table_anchor_info WHERE isLike=true',
        mapper: (Map<String, Object?> row) => ColiveAnchorModel(
            row['app'] as String,
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['channel'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['diamonds'] as String,
            row['disturb'] as String,
            row['gender'] as String,
            row['gold'] as int,
            row['id'] as int,
            row['robot'] as int,
            row['lv'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['signature'] as String,
            row['sys'] as String,
            row['weight'] as int,
            _coliveListAlbumConverter.decode(row['album'] as String),
            _coliveListVideoConverter.decode(row['videos'] as String),
            row['isGreet'] as int,
            _coliveListTagConverter.decode(row['label'] as String),
            row['star'] as String,
            row['height'] as int,
            row['emotion'] as String,
            row['like'] as int,
            (row['isLike'] as int) != 0,
            row['chatNum'] as int,
            (row['isToBlock'] as int) != 0),
        queryableName: 'database_table_anchor_info',
        isView: false);
  }

  @override
  Future<ColiveAnchorModel?> findAnchorById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM database_table_anchor_info WHERE id=?1',
        mapper: (Map<String, Object?> row) => ColiveAnchorModel(
            row['app'] as String,
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['channel'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['diamonds'] as String,
            row['disturb'] as String,
            row['gender'] as String,
            row['gold'] as int,
            row['id'] as int,
            row['robot'] as int,
            row['lv'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['signature'] as String,
            row['sys'] as String,
            row['weight'] as int,
            _coliveListAlbumConverter.decode(row['album'] as String),
            _coliveListVideoConverter.decode(row['videos'] as String),
            row['isGreet'] as int,
            _coliveListTagConverter.decode(row['label'] as String),
            row['star'] as String,
            row['height'] as int,
            row['emotion'] as String,
            row['like'] as int,
            (row['isLike'] as int) != 0,
            row['chatNum'] as int,
            (row['isToBlock'] as int) != 0),
        arguments: [id]);
  }

  @override
  Stream<ColiveAnchorModel?> findAnchorByIdAsStream(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM database_table_anchor_info WHERE id=?1',
        mapper: (Map<String, Object?> row) => ColiveAnchorModel(
            row['app'] as String,
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['channel'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['diamonds'] as String,
            row['disturb'] as String,
            row['gender'] as String,
            row['gold'] as int,
            row['id'] as int,
            row['robot'] as int,
            row['lv'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['signature'] as String,
            row['sys'] as String,
            row['weight'] as int,
            _coliveListAlbumConverter.decode(row['album'] as String),
            _coliveListVideoConverter.decode(row['videos'] as String),
            row['isGreet'] as int,
            _coliveListTagConverter.decode(row['label'] as String),
            row['star'] as String,
            row['height'] as int,
            row['emotion'] as String,
            row['like'] as int,
            (row['isLike'] as int) != 0,
            row['chatNum'] as int,
            (row['isToBlock'] as int) != 0),
        arguments: [id],
        queryableName: 'database_table_anchor_info',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM database_table_anchor_info');
  }

  @override
  Future<void> insertAnchor(ColiveAnchorModel anchorInfo) async {
    await _coliveAnchorModelInsertionAdapter.insert(
        anchorInfo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAnchor(ColiveAnchorModel anchorInfo) async {
    await _coliveAnchorModelUpdateAdapter.update(
        anchorInfo, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAnchor(ColiveAnchorModel anchorInfo) async {
    await _coliveAnchorModelDeletionAdapter.delete(anchorInfo);
  }
}

class _$ColiveChatConversationDao extends ColiveChatConversationDao {
  _$ColiveChatConversationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coliveChatConversationModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_chat_conversation',
            (ColiveChatConversationModel item) => <String, Object?>{
                  'id': item.id,
                  'avatar': item.avatar,
                  'username': item.username,
                  'summary': item.summary,
                  'timestamp': item.timestamp,
                  'unreadCount': item.unreadCount,
                  'orderBy': item.orderBy,
                  'pin': item.pin
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveChatConversationModel>
      _coliveChatConversationModelInsertionAdapter;

  @override
  Stream<List<ColiveChatConversationModel>?> getConversations() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM database_table_chat_conversation ORDER BY orderBy DESC,pin DESC,timestamp DESC',
        mapper: (Map<String, Object?> row) => ColiveChatConversationModel(
            id: row['id'] as String,
            avatar: row['avatar'] as String?,
            username: row['username'] as String?,
            summary: row['summary'] as String?,
            timestamp: row['timestamp'] as int,
            unreadCount: row['unreadCount'] as int,
            orderBy: row['orderBy'] as int,
            pin: row['pin'] as int),
        queryableName: 'database_table_chat_conversation',
        isView: false);
  }

  @override
  Future<List<ColiveChatConversationModel>?> getConversationsWithId(
      String id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM database_table_chat_conversation WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ColiveChatConversationModel(
            id: row['id'] as String,
            avatar: row['avatar'] as String?,
            username: row['username'] as String?,
            summary: row['summary'] as String?,
            timestamp: row['timestamp'] as int,
            unreadCount: row['unreadCount'] as int,
            orderBy: row['orderBy'] as int,
            pin: row['pin'] as int),
        arguments: [id]);
  }

  @override
  Stream<int?> getAllConversationsUnreadCount() {
    return _queryAdapter.queryStream(
        'SELECT sum(unreadCount) FROM database_table_chat_conversation',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        queryableName: 'database_table_chat_conversation',
        isView: false);
  }

  @override
  Future<void> clearConversationUnreadCount(String id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE database_table_chat_conversation SET unreadCount = 0 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> clearAllUnread() async {
    await _queryAdapter.queryNoReturn(
        'UPDATE database_table_chat_conversation SET unreadCount = 0');
  }

  @override
  Future<void> deleteConversationsWithId(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM database_table_chat_conversation WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM database_table_chat_conversation');
  }

  @override
  Future<void> insertAll(
      List<ColiveChatConversationModel> conversations) async {
    await _coliveChatConversationModelInsertionAdapter.insertList(
        conversations, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(ColiveChatConversationModel conversation) async {
    await _coliveChatConversationModelInsertionAdapter.insert(
        conversation, OnConflictStrategy.replace);
  }
}

class _$ColiveOrderDao extends ColiveOrderDao {
  _$ColiveOrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _coliveOrderItemModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_order_info',
            (ColiveOrderItemModel item) => <String, Object?>{
                  'app': item.app,
                  'area': item.area,
                  'cType': item.cType,
                  'channel': item.channel,
                  'channelId': item.channelId,
                  'createTime': item.createTime,
                  'currency': item.currency,
                  'extraNum': item.extraNum,
                  'extraTime': item.extraTime,
                  'goodsId': item.goodsId,
                  'productId': item.productId,
                  'id': item.id,
                  'localPrice': item.localPrice,
                  'num': item.num,
                  'orderNo': item.orderNo,
                  'pType': item.pType,
                  'payCountry': item.payCountry,
                  'price': item.price,
                  'status': item.status,
                  'type': item.type,
                  'uid': item.uid,
                  'version': item.version,
                  'url': item.url
                }),
        _coliveOrderItemModelUpdateAdapter = UpdateAdapter(
            database,
            'database_table_order_info',
            ['productId'],
            (ColiveOrderItemModel item) => <String, Object?>{
                  'app': item.app,
                  'area': item.area,
                  'cType': item.cType,
                  'channel': item.channel,
                  'channelId': item.channelId,
                  'createTime': item.createTime,
                  'currency': item.currency,
                  'extraNum': item.extraNum,
                  'extraTime': item.extraTime,
                  'goodsId': item.goodsId,
                  'productId': item.productId,
                  'id': item.id,
                  'localPrice': item.localPrice,
                  'num': item.num,
                  'orderNo': item.orderNo,
                  'pType': item.pType,
                  'payCountry': item.payCountry,
                  'price': item.price,
                  'status': item.status,
                  'type': item.type,
                  'uid': item.uid,
                  'version': item.version,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveOrderItemModel>
      _coliveOrderItemModelInsertionAdapter;

  final UpdateAdapter<ColiveOrderItemModel> _coliveOrderItemModelUpdateAdapter;

  @override
  Future<List<ColiveOrderItemModel>> getAllAnchors() async {
    return _queryAdapter.queryList('SELECT * FROM database_table_order_info',
        mapper: (Map<String, Object?> row) => ColiveOrderItemModel(
            row['app'] as String,
            row['area'] as String,
            row['cType'] as int,
            row['channel'] as String,
            row['channelId'] as int,
            row['createTime'] as int,
            row['currency'] as String,
            row['extraNum'] as int,
            row['extraTime'] as int,
            row['goodsId'] as int,
            row['productId'] as String,
            row['id'] as int,
            row['localPrice'] as String,
            row['num'] as int,
            row['orderNo'] as String,
            row['pType'] as int,
            row['payCountry'] as String,
            row['price'] as String,
            row['status'] as int,
            row['type'] as int,
            row['uid'] as int,
            row['version'] as String,
            row['url'] as String));
  }

  @override
  Future<ColiveOrderItemModel?> findOrderByProductId(String productId) async {
    return _queryAdapter.query(
        'SELECT * FROM database_table_order_info WHERE productId=?1',
        mapper: (Map<String, Object?> row) => ColiveOrderItemModel(
            row['app'] as String,
            row['area'] as String,
            row['cType'] as int,
            row['channel'] as String,
            row['channelId'] as int,
            row['createTime'] as int,
            row['currency'] as String,
            row['extraNum'] as int,
            row['extraTime'] as int,
            row['goodsId'] as int,
            row['productId'] as String,
            row['id'] as int,
            row['localPrice'] as String,
            row['num'] as int,
            row['orderNo'] as String,
            row['pType'] as int,
            row['payCountry'] as String,
            row['price'] as String,
            row['status'] as int,
            row['type'] as int,
            row['uid'] as int,
            row['version'] as String,
            row['url'] as String),
        arguments: [productId]);
  }

  @override
  Future<void> deleteOrderByProductId(String productId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM database_table_order_info WHERE productId=?1',
        arguments: [productId]);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM database_table_order_info');
  }

  @override
  Future<void> insertOrder(ColiveOrderItemModel orderInfo) async {
    await _coliveOrderItemModelInsertionAdapter.insert(
        orderInfo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateOrder(ColiveOrderItemModel orderInfo) async {
    await _coliveOrderItemModelUpdateAdapter.update(
        orderInfo, OnConflictStrategy.replace);
  }
}

class _$ColiveMomentDao extends ColiveMomentDao {
  _$ColiveMomentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coliveMomentItemModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_moment_info',
            (ColiveMomentItemModel item) => <String, Object?>{
                  'id': item.id,
                  'area': item.area,
                  'avatar': item.avatar,
                  'birthday': item.birthday,
                  'content': item.content,
                  'conversationPrice': item.conversationPrice,
                  'country': item.country,
                  'countryCurrency': item.countryCurrency,
                  'countryIcon': item.countryIcon,
                  'createTime': item.createTime,
                  'images': _coliveListStringConverter.encode(item.images),
                  'robot': item.robot,
                  'like': item.like,
                  'likeNum': item.likeNum,
                  'nickname': item.nickname,
                  'online': item.online,
                  'robotArea': item.robotArea,
                  'robotAvatar': item.robotAvatar,
                  'robotBirthday': item.robotBirthday,
                  'robotCountry': item.robotCountry,
                  'robotNickname': item.robotNickname,
                  'status': item.status,
                  'type': item.type,
                  'uid': item.uid,
                  'updateTime': item.updateTime,
                  'userArea': item.userArea,
                  'isLike': item.isLike ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveMomentItemModel>
      _coliveMomentItemModelInsertionAdapter;

  @override
  Future<List<ColiveMomentItemModel>> findMomentListByAnchorId(
      int anchorId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM database_table_moment_info WHERE uid=?1 ORDER BY createTime DESC',
        mapper: (Map<String, Object?> row) => ColiveMomentItemModel(row['area'] as String, row['avatar'] as String, row['birthday'] as int, row['content'] as String, row['conversationPrice'] as String, row['country'] as String, row['countryCurrency'] as String, row['countryIcon'] as String, row['createTime'] as int, row['id'] as int, _coliveListStringConverter.decode(row['images'] as String), row['robot'] as int, row['like'] as int, row['likeNum'] as int, row['nickname'] as String, row['online'] as int, row['robotArea'] as String, row['robotAvatar'] as String, row['robotBirthday'] as int, row['robotCountry'] as String, row['robotNickname'] as String, row['status'] as String, row['type'] as String, row['uid'] as int, row['updateTime'] as int, row['userArea'] as String, (row['isLike'] as int) != 0),
        arguments: [anchorId]);
  }

  @override
  Future<ColiveMomentItemModel?> findMomentById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM database_table_moment_info WHERE id=?1',
        mapper: (Map<String, Object?> row) => ColiveMomentItemModel(
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['content'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['createTime'] as int,
            row['id'] as int,
            _coliveListStringConverter.decode(row['images'] as String),
            row['robot'] as int,
            row['like'] as int,
            row['likeNum'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['robotArea'] as String,
            row['robotAvatar'] as String,
            row['robotBirthday'] as int,
            row['robotCountry'] as String,
            row['robotNickname'] as String,
            row['status'] as String,
            row['type'] as String,
            row['uid'] as int,
            row['updateTime'] as int,
            row['userArea'] as String,
            (row['isLike'] as int) != 0),
        arguments: [id]);
  }

  @override
  Stream<ColiveMomentItemModel?> findMomentByIdAsStream(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM database_table_moment_info WHERE id=?1',
        mapper: (Map<String, Object?> row) => ColiveMomentItemModel(
            row['area'] as String,
            row['avatar'] as String,
            row['birthday'] as int,
            row['content'] as String,
            row['conversationPrice'] as String,
            row['country'] as String,
            row['countryCurrency'] as String,
            row['countryIcon'] as String,
            row['createTime'] as int,
            row['id'] as int,
            _coliveListStringConverter.decode(row['images'] as String),
            row['robot'] as int,
            row['like'] as int,
            row['likeNum'] as int,
            row['nickname'] as String,
            row['online'] as int,
            row['robotArea'] as String,
            row['robotAvatar'] as String,
            row['robotBirthday'] as int,
            row['robotCountry'] as String,
            row['robotNickname'] as String,
            row['status'] as String,
            row['type'] as String,
            row['uid'] as int,
            row['updateTime'] as int,
            row['userArea'] as String,
            (row['isLike'] as int) != 0),
        arguments: [id],
        queryableName: 'database_table_moment_info',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM database_table_moment_info');
  }

  @override
  Future<void> insertMoment(ColiveMomentItemModel moment) async {
    await _coliveMomentItemModelInsertionAdapter.insert(
        moment, OnConflictStrategy.replace);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coliveSearchHistoryModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_search_history',
            (ColiveSearchHistoryModel item) =>
                <String, Object?>{'history': item.history, 'time': item.time},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveSearchHistoryModel>
      _coliveSearchHistoryModelInsertionAdapter;

  @override
  Stream<List<ColiveSearchHistoryModel>?> getHistoryListByStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM database_table_search_history ORDER BY time DESC LIMIT 10',
        mapper: (Map<String, Object?> row) => ColiveSearchHistoryModel(
            row['history'] as String, row['time'] as int),
        queryableName: 'database_table_search_history',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM database_table_search_history');
  }

  @override
  Future<void> insertHistory(ColiveSearchHistoryModel history) async {
    await _coliveSearchHistoryModelInsertionAdapter.insert(
        history, OnConflictStrategy.replace);
  }
}

class _$ColiveCardDao extends ColiveCardDao {
  _$ColiveCardDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _coliveCardItemModelInsertionAdapter = InsertionAdapter(
            database,
            'database_table_cards',
            (ColiveCardItemModel item) => <String, Object?>{
                  'id': item.id,
                  'desc': item.desc,
                  'expireTime': item.expireTime,
                  'ext': item.ext,
                  'icon': item.icon,
                  'img': item.img,
                  'itemId': item.itemId,
                  'itemType': item.itemType,
                  'name': item.name,
                  'num': item.num
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ColiveCardItemModel>
      _coliveCardItemModelInsertionAdapter;

  @override
  Stream<List<ColiveCardItemModel>?> getCardList() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM database_table_cards ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => ColiveCardItemModel(
            row['desc'] as String,
            row['expireTime'] as int,
            row['ext'] as String,
            row['icon'] as String,
            row['id'] as int,
            row['img'] as String,
            row['itemId'] as int,
            row['itemType'] as int,
            row['name'] as String,
            row['num'] as int),
        queryableName: 'database_table_cards',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM database_table_cards');
  }

  @override
  Future<void> insertAll(List<ColiveCardItemModel> cards) async {
    await _coliveCardItemModelInsertionAdapter.insertList(
        cards, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _coliveListStringConverter = ColiveListStringConverter();
final _coliveListTagConverter = ColiveListTagConverter();
final _coliveListAlbumConverter = ColiveListAlbumConverter();
final _coliveListVideoConverter = ColiveListVideoConverter();
