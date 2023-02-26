import '../entities/chat.dart';

abstract class ApiChatRepository {
  Future<void> addChat(Chat chat);

  Stream<List<Chat>> get chatsStream;

  Future<void> updateChat(Chat chat);

  Future<void> removeChat(Chat chat);

  Future<List<Chat>> getChats();

  Future<Chat> getChat(String id);

  Future<void> updateLast(
    String id,
    String lastMessage,
    DateTime? lastDate,
    bool shouldCheck,
  );
}
