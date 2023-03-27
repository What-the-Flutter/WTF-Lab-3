import '../models/event.dart';
import '../providers/database_provider.dart';

class EventDao {
  final DatabaseProvider _dbProvider;

  EventDao({required DatabaseProvider dbProvider}) : _dbProvider = dbProvider;

  Stream<List<Event>> get eventsStream {
    return _dbProvider.eventsStream.map((event) {
      final snapshot = event.snapshot;
      return snapshot.children
          .map((event) => Event.fromDatabaseMap(
              Map<String, dynamic>.from(event.value as Map)))
          .toList();
    });
  }

  Future<List<Event>> receiveAllChatEvents(String chatId) async {
    final snapshot = await _dbProvider.queryChatEvents(chatId);
    if (snapshot.exists) {
      return snapshot.children
          .map((event) => Event.fromDatabaseMap(
              Map<String, dynamic>.from(event.value as Map)))
          .toList()
        ..sort((a, b) => a.time.compareTo(b.time));
    } else {
      return [];
    }
  }

  Future<List<Event>> receiveAllEvents() async {
    final snapshot = await _dbProvider.queryAllEvents();
    if (snapshot.exists) {
      return snapshot.children
          .map((event) => Event.fromDatabaseMap(
              Map<String, dynamic>.from(event.value as Map)))
          .toList()
        ..sort((a, b) => a.time.compareTo(b.time));
    } else {
      return [];
    }
  }

  Future<void> createEvent(Event event) async {
    return await _dbProvider.insertEvent(event);
  }

  Future<void> updateEvent(Event event) async {
    return await _dbProvider.updateEvent(event.toDatabaseMap());
  }

  Future<void> deleteEvent(Event event) async {
    return await _dbProvider.deleteEvent(event);
  }
}
