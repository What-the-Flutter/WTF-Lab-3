import 'package:chats_api/chats_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageChatsApi implements ChatsApi {
  static const databasePath = 'local_storage_chats_api.database';
  static const version = 1;

  static const chatsTable = 'Chats';
  static const eventsTable = 'Events';
  static const categoriesTable = 'Categories';

  Future<Database>? _database;

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
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        icon INTEGER NOT NULL,
        created_time TEXT NOT NULL,
        is_pinned INTEGER NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE $eventsTable (
        id TEXT PRIMARY KEY,
        chat_id TEXT NOT NULL,
        content TEXT NOT NULL,
        is_image INTEGER NOT NULL,
        is_favorite INTEGER NOT NULL,
        change_time TEXT NOT NULL,
        category STRING 
      )''');

    await db.execute('''
      CREATE TABLE $categoriesTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        icon INTEGER NOT NULL,
        is_custom INTEGER NOT NULL
      )''');
  }

  @override
  Future<List<ChatEntity>> loadChats() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;

    final jsonMap = await db.query(chatsTable);
    return List.generate(
      jsonMap.length,
      (i) => ChatEntity.fromJson(jsonMap[i]),
    );
  }

  @override
  Future<void> saveChats(Iterable<ChatEntity> chats) async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = chats.map((chat) => chat.toJson());
    await db.delete(chatsTable);
    for (final chat in jsonMap) {
      await db.insert(
        chatsTable,
        chat,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<EventEntity>> loadEvents() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = await db.query(eventsTable);
    return List.generate(
      jsonMap.length,
      (i) => EventEntity.fromJson(jsonMap[i]),
    );
  }

  @override
  Future<void> saveEvents(Iterable<EventEntity> events) async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = events.map((event) => event.toJson());
    await db.delete(eventsTable);
    for (final event in jsonMap) {
      await db.insert(
        eventsTable,
        event,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<CategoryEntity>> loadCategories() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = await db.query(categoriesTable);
    return List.generate(
      jsonMap.length,
      (i) => CategoryEntity.fromJson(jsonMap[i]),
    );
  }

  @override
  Future<void> saveCategories(Iterable<CategoryEntity> categories) async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = categories.map((event) => event.toJson());
    await db.delete(categoriesTable);
    for (final event in jsonMap) {
      await db.insert(
        categoriesTable,
        event,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
