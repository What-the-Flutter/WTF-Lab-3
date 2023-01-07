import 'package:flutter/material.dart';
import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider dbProvider = DBProvider();
  Database? _database;
  String chatsTable = 'chats';
  String eventeTable = 'events';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'chatjournal.db'),
      version: 1,
      onCreate: _create,
    );
  }

  Future _create(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $chatsTable(
      ${ChatField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ChatField.title} TEXT,
      ${ChatField.icon} INTEGER,
      ${ChatField.dateCreate} TEXT,
      ${ChatField.pin} TEXT
      )
    ''');

    await db.execute(''' 
      CREATE TABLE $eventeTable(
      ${EventField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${EventField.messageContent} TEXT,
      ${EventField.messageTime} TEXT,
      ${EventField.messageType} TEXT,
      ${EventField.favorite} TEXT,
      ${EventField.messageImage} TEXT,
      ${EventField.chat} INTEGER,
      ${EventField.sectionIcon} INTEGER,
      ${EventField.sectionTitle} TEXT   
      )
    ''');
  }

  Future<List<Chat>> getAllChat() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(chatsTable);

    return List.generate(
      maps.length,
      (i) {
        return Chat(
          id: maps[i]['id'],
          title: maps[i]['${ChatField.title}'],
          icon: Icon(IconData(maps[i]['${ChatField.icon}'], fontFamily: 'MaterialIcons')),
          dateCreate: DateTime.parse(maps[i]['${ChatField.dateCreate}']),
          isPin: maps[i]['${ChatField.pin}'] == 'true',
        );
      },
    );
  }

  Future<void> addChat(Chat chat) async {
    final db = await database;
    await db.insert(
      chatsTable,
      chat.toMap(),
    );
  }

  Future<void> updateChat(Chat chat) async {
    final db = await database;
    await db.update(
      chatsTable,
      chat.toMap(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> deleteChat(Chat chat) async {
    final db = await database;
    await db.delete(
      chatsTable,
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }
}
