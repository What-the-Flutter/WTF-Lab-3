import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class DatabaseProvider {
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
        icon_code INTEGER NOT NULL,
        name TEXT NOT NULL,
        created_time TEXT NOT NULL,
        is_pinned INTEGER NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE $eventsTable (
        id TEXT PRIMARY KEY,
        content TEXT NOT NULL,
        is_image INTEGER NOT NULL,
        is_favorite INTEGER NOT NULL,
        change_time TEXT NOT NULL,
        chat_id TEXT NOT NULL,
        category_id TEXT 
      )''');

    await db.execute('''
      CREATE TABLE $categoriesTable (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        icon INTEGER NOT NULL,
        is_custom INTEGER NOT NULL
      )''');
  }

  Future<List<Chat>> loadChats() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;

    final jsonMap = await db.query(chatsTable);
    return List.generate(
      jsonMap.length,
      (i) => Chat.fromJson(jsonMap[i]),
    );
  }

  Future<void> saveChats(Iterable<Chat> chats) async {
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

  Future<List<Event>> loadEvents() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = await db.query(eventsTable);
    return List.generate(
      jsonMap.length,
      (i) => Event.fromJson(jsonMap[i]),
    );
  }

  Future<void> saveEvents(Iterable<Event> events) async {
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

  Future<List<Category>> loadCategories() async {
    if (_database == null) {
      await _init();
    }

    final db = await _database!;
    final jsonMap = await db.query(categoriesTable);
    return List.generate(
      jsonMap.length,
      (i) => Category.fromJson(jsonMap[i]),
    );
  }

  Future<void> saveCategories(Iterable<Category> categories) async {
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