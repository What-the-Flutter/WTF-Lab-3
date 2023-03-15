import '../dao/event_dao.dart';
import '../models/event.dart';

class EventRepository {
  final eventDao = EventDao();

  Future<List<Event>> receiveAllChatEvents(String chatId) =>
      eventDao.receiveAllChatEvents(chatId);

  Future<int> insertEvent(Event event) => eventDao.createEvent(event);

  Future<int> updateEvent(Event event) => eventDao.updateEvent(event);

  Future<int> deleteEventById(String id) => eventDao.deleteEvent(id);
}
