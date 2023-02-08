import '../entities/chat.dart';

abstract class ApiChatRepository {
  Future<void> addChat(Chat chat);

  Future<void> updateChat(Chat chat);

  Future<void> removeChat(Chat chat);

  Future<List<Chat>> getChats();
}
