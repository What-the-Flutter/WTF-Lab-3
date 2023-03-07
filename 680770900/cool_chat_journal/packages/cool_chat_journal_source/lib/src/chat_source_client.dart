import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/models.dart';

class ChatSourceClientException implements Exception {}

class ChatSourceClient {
  static const chatsTable = 'Chats';
  static const eventsTable = 'Events';
  static const databasePath = 'cool_chat_journal.db';

  Future<Database>? database;

  Future<void> init() async {
    database = openDatabase(
      join(await  getDatabasesPath(), databasePath),
      onCreate: _onCreate,
      version: 1, 
    );
  }

  Future<void> insertChat(Chat chat) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();

    await db.insert(
      chatsTable,
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Chat>> readChats() async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    final maps = await db.query(chatsTable);
    return List.generate(
      maps.length,
      (i) => Chat.fromMap(maps[i]),
    );
  } 

  Future<void> updateChat(Chat chat) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    await db.update(
      chatsTable,
      chat.toMap(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> deleteChat(int chatId) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    await db.delete(
      chatsTable,
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }
    
  Future<void> insertEvent(Event event) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();

    await db.insert(
      eventsTable,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> readEvents() async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    final maps = await db.query(eventsTable);
    return List.generate(
      maps.length,
      (i) => Event.fromMap(maps[i]),
    );
  } 

  Future<void> updateEvent(Event event) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    await db.update(
      eventsTable,
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(int eventId) async {
    final db = await database;
    if (db == null) throw ChatSourceClientException();
    
    await db.delete(
      eventsTable,
      where: 'id = ?',
      whereArgs: [eventId],
    );
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $chatsTable (
        id INTEGER PRIMARY KEY,
        icon TEXT NOT NULL,
        createdTime TEXT NOT NULL,
        isPinned INT NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE $eventsTable (
        if INTEGER PRIMARY KEY,
        content TEXT NOT NULL,
        isImage INTEGER NOT NULL,
        changeTime TEXT NOT NULL,
        category STRING NOT NULL, 
      )''');
  }
} 