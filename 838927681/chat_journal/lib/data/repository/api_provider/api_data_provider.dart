import '../../models/db_chat.dart';
import '../../models/db_event.dart';
import '../../models/db_tag.dart';

abstract class ApiDataProvider {
  Future<DBChat> getChat(String id);

  Stream<List<DBChat>> get chatsStream;

  Stream<List<DBEvent>> get eventsStream;

  Stream<List<DBTag>> get tagsStream;

  Future<void> addChat(DBChat chat);

  Future<void> addTag(DBTag tag);

  Future<List<DBChat>> get chats;

  Future<List<DBTag>> get tags;

  Future<void> deleteChat(DBChat chat);
  
  Future<void> deleteTag(DBTag tag);

  Future<void> updateChat(DBChat chat);

  Future<void> updateTag(DBTag tag);

  Future<void> addEvent(DBEvent event);

  Future<void> deleteEvent(DBEvent event);

  Future<List<DBEvent>> get events;

  Future<void> updateEvent(DBEvent event);
}
