import '../database/database_provider.dart';
import '../models/chat.dart';

class ChatDao {
  final DatabaseProvider _dbProvider;

  ChatDao({required DatabaseProvider dbProvider}) : _dbProvider = dbProvider;

  Stream<List<Chat>> get chatsStream {
    return _dbProvider.chatsStream.map((event) {
      final snapshot = event.snapshot;
      return snapshot.children
          .map((chat) => Chat.fromDatabaseMap(
              Map<String, dynamic>.from(chat.value as Map)))
          .toList();
    });
  }

  Future<List<Chat>> receiveChats() async {
    final snapshot = await _dbProvider.queryAllChats();
    if (snapshot.exists) {
      return snapshot.children
          .map((chat) => Chat.fromDatabaseMap(
              Map<String, dynamic>.from(chat.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> createChat(Chat chat) async {
    return await _dbProvider.insertChat(chat.toDatabaseMap());
  }

  Future<void> updateChat(Chat chat) async {
    return await _dbProvider.updateChat(chat.toDatabaseMap());
  }

  Future<void> deleteChat(String id) async {
    return await _dbProvider.deleteChat(id);
  }
}
