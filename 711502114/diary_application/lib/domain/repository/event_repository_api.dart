import 'package:diary_application/domain/models/event.dart';

abstract class EventRepositoryApi {
  Future<void> addEvent(Event event);

  Future<void> deleteEvent(Event event);

  Future<void> changeEvent(Event event);

  Future<List<Event>> getEvents(String chatId);

  Stream<List<Event>> get eventStream;

  Future<List<Event>> getAllEvents();
}
