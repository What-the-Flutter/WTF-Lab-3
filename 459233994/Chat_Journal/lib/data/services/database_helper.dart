import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'chat_journal_database.db';
  static final _databaseVersion = 1;

  static final tableChats = 'chats';
  static final tableEvents = 'events';

  static final columnChatId = 'chat_id';
  static final columnName = 'name';
  static final columnChatCreateTime = 'create_time';
  static final columnPageIcon = 'page_icon';
  static final columnIsPinned = 'is_pinned';

  static final columnEventId = 'event_id';
  static final columnEventCreateTime = 'create_time';
  static final columnTextData = 'text_data';
  static final columnImageData = 'image_data';
  static final columnCategory = 'category';
  static final columnIsDone = 'is_done';
  static final columnIsFavorite = 'is_favorite';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableChats (
        $columnChatId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnChatCreateTime TEXT NOT NULL,
        $columnPageIcon TEXT NOT NULL,
        $columnIsPinned INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableEvents (
        $columnEventId INTEGER PRIMARY KEY,
        $columnChatId INTEGER NOT NULL,
        $columnEventCreateTime TEXT NOT NULL,
        $columnTextData TEXT,
        $columnImageData TEXT,
        $columnCategory TEXT,
        $columnIsDone INTEGER NOT NULL,
        $columnIsFavorite INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertChat(Map<String, dynamic> row) async {
    var db = await instance.database;
    return await db.insert(tableChats, row);
  }

  Future<void> updateChat(
    int id,
    Map<String, dynamic> newValue,
  ) async {
    final db = await instance.database;
    await db.update(
      tableChats,
      {
        columnName: newValue['name'],
        columnIsPinned: newValue['is_pinned'],
        columnPageIcon: newValue['page_icon'],
      },
      where: '$columnChatId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteChat(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableChats,
      where: '$columnChatId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllChats() async {
    var db = await instance.database;
    return await db.query(tableChats);
  }

  Future<int> insertEvent(Map<String, dynamic> row) async {
    var db = await instance.database;
    return await db.insert(tableEvents, row);
  }

  Future<void> updateEvent(int id, Map<String, dynamic> newValue) async {
    final db = await instance.database;
    await db.update(
      tableEvents,
      {
        columnChatId: newValue['chat_id'],
        columnTextData: newValue['text_data'],
        columnIsDone: newValue['is_done'],
        columnIsFavorite: newValue['is_favorite'],
      },
      where: '$columnEventId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableEvents,
      where: '$columnEventId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllEventsForChat(int chatId) async {
    var db = await instance.database;
    return await db.query(
      tableEvents,
      where: '$columnChatId = ?',
      whereArgs: [chatId],
    );
  }
}
