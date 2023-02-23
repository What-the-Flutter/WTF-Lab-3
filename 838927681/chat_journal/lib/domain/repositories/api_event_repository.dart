import '../entities/event.dart';

abstract class ApiEventRepository {
  Stream<List<Event>> get eventStream;

  Future<List<Event>> getEvents(String parentId);

  Future<void> addEvent(Event event);

  Future<void> deleteEvent(Event event);

  Future<void> updateEvent(Event event);
}
