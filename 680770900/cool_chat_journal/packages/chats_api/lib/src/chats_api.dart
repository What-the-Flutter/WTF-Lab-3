import 'models/models.dart';

class ChatNotFoundException implements Exception {}

abstract class ChatsApi {
  const ChatsApi();

  Future<List<ChatEntity>> loadChats();
  Future<List<EventEntity>> loadEvents();
  Future<List<CategoryEntity>> loadCategories();

  Future<void> saveChats(Iterable<ChatEntity> chats);
  Future<void> saveEvents(Iterable<EventEntity> events);
  Future<void> saveCategories(Iterable<CategoryEntity> categories);
}