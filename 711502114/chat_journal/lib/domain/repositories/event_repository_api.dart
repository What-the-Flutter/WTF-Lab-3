import '../models/event.dart';

abstract class EventRepositoryApi {
  Future<void> addEvent(Event event);

  Future<void> deleteEvent(Event event);

  Future<void> changeEvent(Event event);

  Future<List<Event>> getEvents();
}