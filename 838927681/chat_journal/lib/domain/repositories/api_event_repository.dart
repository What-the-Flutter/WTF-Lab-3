import '../entities/event.dart';

abstract class ApiEventRepository {
  Future<List<Event>> getEvents(int parentId);

  Future<void> addEvent(Event event);

  Future<void> deleteEvent(Event event);

  Future<void> updateEvent(Event event);
}
