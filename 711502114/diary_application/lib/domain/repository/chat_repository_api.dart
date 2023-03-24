import 'package:diary_application/domain/models/chat.dart';

abstract class ChatRepositoryApi {
  Future<void> addChat(Chat chat);

  Stream<List<Chat>> get chatsStream;

  Future<void> deleteChat(Chat chat);

  Future<void> changeChat(Chat chat);

  Future<List<Chat>> getChats();

  Future<Chat> getChat(String id);

  Future<void> updateLastChat(
    String id,
    String? lastEvent,
    String? eventTime,
    bool check,
  );
}
