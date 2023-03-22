import '../database/database_provider.dart';
import '../models/event.dart';

class EventDao {
  final DatabaseProvider _dbProvider;

  EventDao({required DatabaseProvider dbProvider}) : _dbProvider = dbProvider;

  Stream<List<Event>> get eventsStream {
    return _dbProvider.eventsStream.map((event) {
      final snapshot = event.snapshot;
      return snapshot.children
          .map((e) =>
              Event.fromDatabaseMap(Map<String, dynamic>.from(e.value as Map)))
          .toList();
    });
  }

  Future<List<Event>> receiveAllChatEvents(String chatId) async {
    final snapshot = await _dbProvider.queryAllEvents(chatId);
    if (snapshot.exists) {
      return snapshot.children
          .map((e) =>
              Event.fromDatabaseMap(Map<String, dynamic>.from(e.value as Map)))
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

  Future<void> deleteEvent(String id) async {
    return await _dbProvider.deleteEvent(id);
  }
}
