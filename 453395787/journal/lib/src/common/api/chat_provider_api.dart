import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../models/chat.dart';

abstract class ChatProviderApi {
  Future<IList<Chat>> getAll();

  Future<Chat?> get(int id);

  Future<void> add(Chat chat);

  Future<void> addAll(IList<Chat> chats);

  Future<void> update(Chat chat);

  Future<void> updateAll(IList<Chat> chats);

  Future<void> delete(int id);

  Future<void> deleteAll(IList<int> ids);
}
