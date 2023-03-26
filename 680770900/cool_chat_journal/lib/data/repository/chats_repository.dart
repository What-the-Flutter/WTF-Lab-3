import 'package:get_it/get_it.dart';

import '../models/models.dart';
import '../provider/database_provider.dart';

class ChatsRepository {
  const ChatsRepository();

  Future<List<Chat>> readChats() async {
    final jsonChats = await GetIt.I<DatabaseProvider>().read<Chat>(
      tableName: DatabaseProvider.chatsRoot,
    );

    return jsonChats.map(Chat.fromJson).toList();
  }

  Future<void> addChat(Chat chat) async =>
      await GetIt.I<DatabaseProvider>().add(
        json: chat.toJson(),
        tableName: DatabaseProvider.chatsRoot,
      );

  Future<void> deleteChat(String chatId) async =>
      await GetIt.I<DatabaseProvider>().delete(
        id: chatId,
        tableName: DatabaseProvider.chatsRoot,
      );

  Future<void> updateChat(Chat chat) async {
    await GetIt.I<DatabaseProvider>().delete(
      id: chat.id,
      tableName: DatabaseProvider.chatsRoot,
    );
    await GetIt.I<DatabaseProvider>().add(
      json: chat.toJson(),
      tableName: DatabaseProvider.chatsRoot,
    );
  }

  Stream<List<Chat>> get chatsStream => GetIt.I<DatabaseProvider>().chatsStream;
}
