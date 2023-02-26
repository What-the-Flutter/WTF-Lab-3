import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/chat_db.dart';
import '../entities/event_db.dart';

class DataProvider {
  static final databaseName = 'chat_journal.db';

  Database? _db;
  final chatsTable = 'Chats';
  final eventsTable = 'Events';

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $chatsTable('
          '${ChatFields.id} INTEGER PRIMARY KEY NOT NULL, '
          '${ChatFields.title} TEXT, '
          '${ChatFields.iconNumber} INTEGER, '
          '${ChatFields.creationTime} TEXT, '
          '${ChatFields.isPin} INTEGER, '
          '${ChatFields.isArchive} INTEGER'
          ')',
        );
        await db.execute(
          'CREATE TABLE $eventsTable('
          '${EventFields.id} INTEGER PRIMARY KEY NOT NULL, '
          '${EventFields.chatId} INTEGER, '
          '${EventFields.message} TEXT, '
          '${EventFields.creationTime} TEXT, '
          '${EventFields.isFavorite} INTEGER, '
          '${EventFields.photoPath} TEXT, '
          '${EventFields.categoryName} TEXT'
          ')',
        );
      },
    );
  }

  Future<void> addChat(ChatDB chat) async {
    final db = await database;
    await db.insert(
      chatsTable,
      chat.map(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatDB>> get chats async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(chatsTable);
    return List.generate(
      maps.length,
      (i) {
        return ChatDB(
          id: maps[i][ChatFields.id],
          title: maps[i][ChatFields.title],
          iconNumber: maps[i][ChatFields.iconNumber],
          creationTime: maps[i][ChatFields.creationTime],
          isPin: maps[i][ChatFields.isPin],
          isArchive: maps[i][ChatFields.isArchive],
        );
      },
    );
  }

  Future<void> deleteChat(ChatDB chat) async {
    final db = await database;
    await db.delete(
      chatsTable,
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> updateChat(ChatDB chat) async {
    final db = await database;
    await db.update(
      chatsTable,
      chat.map(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> addEvent(EventDB eventDB) async {
    final db = await database;
    await db.insert(
      eventsTable,
      eventDB.map(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<EventDB>> get events async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(eventsTable);
    return List<EventDB>.generate(
      maps.length,
          (i) {
        return EventDB(
          id: maps[i][EventFields.id],
          chatId: maps[i][EventFields.chatId],
          message: maps[i][EventFields.message],
          creationTime: maps[i][EventFields.creationTime],
          isFavorite: maps[i][EventFields.isFavorite],
          photoPath: maps[i][EventFields.photoPath],
          categoryName: maps[i][EventFields.categoryName],
        );
      },
    );
  }

  Future<void> deleteEvent(EventDB event) async {
    final db = await database;
    await db.delete(
      eventsTable,
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> updateEvent(EventDB event) async {
    final db = await database;
    await db.update(
      eventsTable,
      event.map(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }
}
