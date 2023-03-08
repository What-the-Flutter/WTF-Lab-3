import 'package:chats_api/chats_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageChatsApi implements ChatsApi {
  static const databasePath = 'local_storage_chats_api.database';
  static const version = 1;

  static const chatsTable = 'Chats';
  static const eventsTable = 'Events';

  late Future<Database> _database;

  LocalStorageChatsApi() {
    _init();
  }

  Future<void> _init() async {
    _database = openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: _onCreate,
      version: version, 
    );
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $chatsTable (
        id INTEGER PRIMARY KEY,
        icon INTEGER NOT NULL,
        name TEXT NOT NULL,
        createdTime TEXT NOT NULL,
        isPinned INT NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE $eventsTable (
        id INTEGER PRIMARY KEY,
        chatId INTEGER NOT NULL,
        content TEXT NOT NULL,
        isImage INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL,
        changeTime TEXT NOT NULL,
        category STRING 
      )''');
  }
  
  @override
  Future<List<ChatEntity>> loadChats() async {
    final db = await _database;
    final jsonMap = await db.query(chatsTable);
    return List.generate(
      jsonMap.length,
      (i) => ChatEntity.fromJson(jsonMap[i]),
    );
  }
  
  @override
  Future<void> saveChats(Iterable<ChatEntity> chats) async {
    final db = await _database;
    final jsonMap = chats.map((chat) => chat.toJson());
    await db.delete(chatsTable);
    for (final chat in jsonMap) {
      await db.insert(chatsTable, chat);
    }
  }
  
  @override
  Future<List<EventEntity>> loadEvents() async {
    final db = await _database;
    final jsonMap = await db.query(eventsTable);
    return List.generate(
      jsonMap.length,
      (i) => EventEntity.fromJson(jsonMap[i]),
    );
  }
  
  @override
  Future<void> saveEvents(Iterable<EventEntity> events) async {
    final db = await _database;
    final jsonMap = events.map((event) => event.toJson());
    await db.delete(eventsTable);
    for (final event in jsonMap) {
      await db.insert(eventsTable, event);
    }
  }
  
}