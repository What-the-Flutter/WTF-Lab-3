import '../database/database_provider.dart';
import '../models/event.dart';

class EventDao {
  final dbProvider = DatabaseProvider();

  Future<List<Event>> receiveAllChatEvents(String chatId) async {
    final db = await dbProvider.database;
    var result = await db.query(
      eventTable,
      where: 'chat_id = ?',
      whereArgs: [chatId],
    );
    return result.map(Event.fromDatabaseMap).toList();
  }

  Future<int> createEvent(Event event) async {
    final db = await dbProvider.database;
    var result = await db.insert(eventTable, event.toDatabaseMap());
    return result;
  }

  Future<int> updateEvent(Event event) async {
    final db = await dbProvider.database;
    var result = await db.update(
      eventTable,
      event.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
    return result;
  }

  Future<int> deleteEvent(String id) async {
    final db = await dbProvider.database;
    var result = await db.delete(eventTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
