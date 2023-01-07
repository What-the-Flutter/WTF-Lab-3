import '../data/models/chat.dart';

abstract class ChatProviderApi {
  Stream<List<Chat>> getChats();

  Future<void> loadData();

  Future<void> saveChat(Chat chat);

  Future<void> deleteChat(int id);
}
