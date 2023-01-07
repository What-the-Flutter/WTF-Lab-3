import '../data/models/chat.dart';

abstract class ChatRepositoryApi {
  Stream<List<Chat>> get chats;

  Future<void> loadData();

  Future<void> add(Chat chat);

  Future<void> update(Chat chat);

  Future<void> remove(Chat chat);

  Future<void> pin(Chat chat);

  Future<void> unpin(Chat chat);

  Future<void> togglePin(Chat chat);

  Future<Chat> findById(int id);
}
