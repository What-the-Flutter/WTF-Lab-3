import '../dao/event_dao.dart';
import '../models/event.dart';

class EventRepository {
  final EventDao eventDao;

  EventRepository({required this.eventDao});

  Stream<List<Event>> get eventsStream => eventDao.eventsStream;

  Future<List<Event>> receiveAllChatEvents(String chatId) =>
      eventDao.receiveAllChatEvents(chatId);

  Future<void> insertEvent(Event event) => eventDao.createEvent(event);

  Future<void> updateEvent(Event event) => eventDao.updateEvent(event);

  Future<void> deleteEvent(Event event) => eventDao.deleteEvent(event);
}
