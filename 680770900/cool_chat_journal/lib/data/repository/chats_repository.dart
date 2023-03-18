import '../models/models.dart';
import '../provider/database_provider.dart';

class ChatsRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  Future<List<Chat>> loadChats() async => _dbProvider.loadChats();

  Future<void> addChat(Chat chat) async {
    final chats = await _dbProvider.loadChats();
    chats.add(chat);
    await _dbProvider.saveChats(chats);
  }

  Future<void> deleteChat(String chatId) async {
    final chats = await _dbProvider.loadChats();
    await _dbProvider.saveChats(chats.where((chat) => chat.id != chatId));
  }

  Future<void> updateChat(Chat chat) async {
    final oldChats = await _dbProvider.loadChats();
    final chats = oldChats.where((e) => e.id != chat.id).toList();
    chats.add(chat);
    await _dbProvider.saveChats(chats);
  }
}
