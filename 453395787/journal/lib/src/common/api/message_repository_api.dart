
import '../data/models/chat.dart';
import '../data/models/message.dart';

abstract class MessageRepositoryApi {
  Stream<Chat> get stream;

  Future<void> loadData();

  Future<void> add(Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);
}