import '../models/chat.dart';

abstract class ChatRepositoryApi {
  Future<void> addChat(Chat chat);

  Future<void> deleteChat(Chat chat);

  Future<void> changeChat(Chat chat);

  Future<List<Chat>> getChats();
}
