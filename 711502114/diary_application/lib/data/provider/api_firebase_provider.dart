import 'package:diary_application/data/entities/chat_db.dart';
import 'package:diary_application/data/entities/event_db.dart';

abstract class ApiDataProvider {
  Future<ChatDB> getChat(String id);

  Stream<List<ChatDB>> get chatsStream;

  Stream<List<EventDB>> get eventsStream;

  Future<void> addChat(ChatDB chat);

  Future<List<ChatDB>> get chats;

  Future<void> deleteChat(ChatDB chat);

  Future<void> updateChat(ChatDB chat);

  Future<void> addEvent(EventDB event);

  Future<void> deleteEvent(EventDB event);

  Future<List<EventDB>> get events;

  Future<void> updateEvent(EventDB event);
}
