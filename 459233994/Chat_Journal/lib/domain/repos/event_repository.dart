import '../entities/event.dart';

abstract class EventRepository{
  Future<List<Event>> getEvents(int chatId);

  Future<void> insertEvent(Event event);

  Future<void> changeEvent(Event event);

  Future<void> deleteEvent(Event event);
}