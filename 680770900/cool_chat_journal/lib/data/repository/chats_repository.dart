import '../models/models.dart';
import '../provider/database_provider.dart';

class ChatsRepository {
  final DatabaseProvider _databaseProvider;

  const ChatsRepository(this._databaseProvider);

  Future<List<Chat>> readChats() async {
    final jsonChats = await _databaseProvider.read<Chat>(
      tableName: DatabaseProvider.chatsRoot,
    );

    return jsonChats.map(Chat.fromJson).toList();
  }

  Future<void> addChat(Chat chat) async => await _databaseProvider.add(
        json: chat.toJson(),
        tableName: DatabaseProvider.chatsRoot,
      );

  Future<void> deleteChat(String chatId) async =>
      await _databaseProvider.delete(
        id: chatId,
        tableName: DatabaseProvider.chatsRoot,
      );

  Future<void> updateChat(Chat chat) async {
    await _databaseProvider.delete(
      id: chat.id,
      tableName: DatabaseProvider.chatsRoot,
    );
    await _databaseProvider.add(
      json: chat.toJson(),
      tableName: DatabaseProvider.chatsRoot,
    );
  }

  Stream<List<Chat>> get chatsStream => _databaseProvider.chatsStream;
}
