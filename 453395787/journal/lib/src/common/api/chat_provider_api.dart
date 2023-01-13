import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../models/chat.dart';

abstract class ChatProviderApi {
  Future<IList<Chat>> getChats();

  Future<Chat?> getChat(int id);

  Future<void> addChat(Chat chat);

  Future<void> addChats(IList<Chat> chats);

  Future<void> updateChat(Chat chat);

  Future<void> updateChats(IList<Chat> chats);

  Future<void> deleteChat(int id);

  Future<void> deleteChats(IList<int> ids);
}
