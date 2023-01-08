import 'dart:io';

import 'package:flutter/material.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/entities/section.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider dbProvider = DBProvider();
  Database? _database;
  String chatsTable = 'chats';
  String eventeTable = 'events';
  String sectionTable = 'sections';

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
      ${EventField.chatId} INTEGER,
      ${EventField.sectionIcon} INTEGER,
      ${EventField.sectionTitle} TEXT   
      )
    ''');

    await db.execute('''
      CREATE TABLE $sectionTable(
        ${SectionField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${SectionField.titleSection} TEXT,
        ${SectionField.iconSection} TEXT,
      )
    ''');
  }

  Future<List<Section>> getAllSection() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(sectionTable);

    return List.generate(
      maps.length,
      (i) {
        return Section(
          id: maps[i]['${ChatField.id}'],
          iconSection:
              IconData(maps[i]['${SectionField.iconSection}'], fontFamily: 'MaterialIcons'),
          titleSection: maps[i]['${SectionField.titleSection}'],
        );
      },
    );
  }

  Future<List<Chat>> getAllChat() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(chatsTable);

    return List.generate(
      maps.length,
      (i) {
        return Chat(
          id: maps[i]['${ChatField.id}'],
          title: maps[i]['${ChatField.title}'],
          icon: Icon(IconData(maps[i]['${ChatField.icon}'], fontFamily: 'MaterialIcons')),
          dateCreate: DateTime.parse(maps[i]['${ChatField.dateCreate}']),
          isPin: maps[i]['${ChatField.pin}'] == 'true',
        );
      },
    );
  }

  Future<List<Event>> getAllEvent() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(eventeTable);
    return List.generate(
      maps.length,
      (i) {
        return Event(
          id: maps[i]['${EventField.id}'],
          messageContent: maps[i]['${EventField.messageContent}'],
          messageType: maps[i]['${EventField.messageType}'],
          messageTime: DateTime.parse(maps[i]['${EventField.messageTime}']),
          isFavorit: maps[i]['${EventField.favorite}'] == 'true',
          chatId: maps[i]['${EventField.chatId}'],
          messageImage: maps[i]['${EventField.messageImage}'] != null
              ? File(maps[i]['${EventField.messageImage}'])
              : null,
          sectionIcon: maps[i]['${EventField.sectionIcon}'] != null
              ? IconData(maps[i]['${EventField.sectionIcon}'], fontFamily: 'MaterialIcons')
              : null,
          sectionTitle: maps[i]['${EventField.sectionTitle}'],
        );
      },
    );
  }

  Future<Chat> addChat(Chat chat) async {
    final db = await dbProvider.database;
    final id = await db.insert(
      chatsTable,
      chat.toMap(),
    );
    return chat.copyWith(id: id);
  }

  Future<Section> addSection(Section section) async {
    final db = await dbProvider.database;
    final id = await db.insert(
      sectionTable,
      section.toMap(),
    );
    return section.copyWith(id: id);
  }

  Future<Event> addEvent(Event event) async {
    final db = await dbProvider.database;
    final id = await db.insert(
      eventeTable,
      event.toMap(),
    );
    return event.copyWith(id: id);
  }

  Future<void> updateChat(Chat chat) async {
    final db = await dbProvider.database;
    await db.update(
      chatsTable,
      chat.toMap(),
      where: '${ChatField.id} = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> updateEvent(Event event) async {
    final db = await dbProvider.database;
    await db.update(
      eventeTable,
      event.toMap(),
      where: '${EventField.id} = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteChat(Chat chat) async {
    final db = await dbProvider.database;
    await db.delete(
      chatsTable,
      where: '${ChatField.id} = ?',
      whereArgs: [chat.id],
    );
  }

  Future<void> deleteEventById(int id) async {
    final db = await dbProvider.database;
    db.delete(
      eventeTable,
      where: '${EventField.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllEvent(Chat chat) async {
    final db = await dbProvider.database;
    db.delete(
      eventeTable,
      where: '${EventField.chatId} = ?',
      whereArgs: [chat.id],
    );
  }

  Future closeDataBase() async {
    final db = await dbProvider.database;
    db.close();
  }
}
