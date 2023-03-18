import '../models/models.dart';
import '../provider/database_provider.dart';

class EventsRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  Future<List<Event>> loadEvents() async => _dbProvider.loadEvents();

  Future<void> addEvents(Iterable<Event> newEvents) async {
    final events = await _dbProvider.loadEvents();
    events.addAll(newEvents);
    await _dbProvider.saveEvents(events);
  }

  Future<void> updateEvents(Iterable<Event> newEvents) async {
    final updatedEventsIds = newEvents.map((event) => event.id);

    final oldEvents = await _dbProvider.loadEvents();
    final events = oldEvents
      .where((e) => !updatedEventsIds.contains(e.id)).toList();

    events.addAll(newEvents);
    await _dbProvider.saveEvents(events);
  }

  Future<void> addEvent(Event event) async {
    final events = await _dbProvider.loadEvents();
    events.add(event);
    await _dbProvider.saveEvents(events);
  }

  Future<void> deleteEvent(String eventId) async {
    final events = await _dbProvider.loadEvents();
    await _dbProvider.saveEvents(events.where((event) => event.id != eventId));
  }

  Future<void> updateEvent(Event event) async {
    final oldEvents = await _dbProvider.loadEvents();
    final events = oldEvents.where((e) => e.id != event.id).toList();
    events.add(event);
    await _dbProvider.saveEvents(events);
  }

  Future<void> deleteEventsFromChat(String chatId) async {
    final events = await _dbProvider.loadEvents();
    await _dbProvider.saveEvents(
      events.where((event) => event.chatId != chatId),
    );
  }
}
