import '../../models/db_chat.dart';
import '../../models/db_event.dart';

abstract class ApiDataProvider {
  Future<DBChat> getChat(String id);

  Stream<List<DBChat>> get chatsStream;

  Stream<List<DBEvent>> get eventsStream;

  Future<void> addChat(DBChat chat);

  Future<List<DBChat>> get chats;

  Future<void> deleteChat(DBChat chat);

  Future<void> updateChat(DBChat chat);

  Future<void> addEvent(DBEvent event);

  Future<void> deleteEvent(DBEvent event);

  Future<List<DBEvent>> get events;

  Future<void> updateEvent(DBEvent event);
}
