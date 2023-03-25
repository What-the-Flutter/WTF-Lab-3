import 'package:sqflite/sqflite.dart';

import '../database/database_provider.dart';
import '../models/chat.dart';

class ChatDao {
  final DatabaseProvider dbProvider;

  ChatDao({required this.dbProvider});

  Future<List<Chat>> receiveChats() async {
    final db = await dbProvider.database;
    final result = await db.query(chatTable);
    return result.map(Chat.fromDatabaseMap).toList();
  }

  Future<int> createChat(Chat chat) async {
    final db = await dbProvider.database;
    final result = await db.insert(
      chatTable,
      chat.toDatabaseMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result;
  }

  Future<int> updateChat(Chat chat) async {
    final db = await dbProvider.database;
    final result = await db.update(
      chatTable,
      chat.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
    return result;
  }

  Future<int> deleteChat(String id) async {
    final db = await dbProvider.database;
    final result = await db.delete(chatTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
