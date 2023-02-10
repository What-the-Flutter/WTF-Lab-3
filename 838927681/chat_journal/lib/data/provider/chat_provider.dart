import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/db_chat.dart';
import '../models/db_event.dart';

class DataProvider {
  Database? _database;
  final chatsTable = 'Chats';
  final eventsTable = 'Events';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'chat_journal_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $chatsTable('
          'id INTEGER PRIMARY KEY NOT NULL, '
          'name TEXT,'
          ' iconIndex INTEGER, '
          'creationDate TEXT'
          ')',
        );
        await db.execute(
          'CREATE TABLE $eventsTable('
          'id INTEGER PRIMARY KEY NOT NULL, '
          'parentId INTEGER,'
          'text TEXT,'
          'imagePath TEXT,'
          'iconIndex INTEGER,'
          'dateTime TEXT,'
          'isFavorite INTEGER,'
          'isSelected INTEGER'
          ')',
        );
      },
    );
  }

  Future<void> addChat(DBChat chat) async {
    final db = await database;
    await db.insert(
      chatsTable,
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DBChat>> get chats async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(chatsTable);
    return List.generate(
      maps.length,
      (index) {
        return DBChat(
          id: maps[index]['id'],
          name: maps[index]['name'],
          creationDate: maps[index]['creationDate'],
          iconIndex: maps[index]['iconIndex'],
        );
      },
    );
  }

  Future<void> deleteChat(DBChat chat) async {
    final db = await database;
    await db.delete(
      chatsTable,
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> updateChat(DBChat chat) async {
    final db = await database;
    await db.update(
      chatsTable,
      chat.toMap(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> addEvent(DBEvent event) async {
    final db = await database;
    db.insert(
      eventsTable,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEvent(DBEvent event) async {
    final db = await database;
    db.delete(
      eventsTable,
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<List<DBEvent>> get events async {
    final db = await database;
    List<Map<String, dynamic>> events = await db.query(eventsTable);
    return List<DBEvent>.generate(
      events.length,
      (index) {
        return DBEvent(
          id: events[index]['id'],
          parentId: events[index]['parentId'],
          text: events[index]['text'],
          dateTime: events[index]['dateTime'],
          isFavorite: events[index]['isFavorite'],
          imagePath: events[index]['imagePath'],
          iconIndex: events[index]['iconIndex'],
        );
      },
    );
  }

  Future<void> updateEvent(DBEvent event) async {
    final db = await database;
    await db.update(
      eventsTable,
      event.toMap(),
      whereArgs: [event.id],
      where: 'id = ?',
    );
  }
}
