import '../dao/chat_dao.dart';
import '../models/chat.dart';

class ChatRepository {
  final ChatDao chatDao;

  ChatRepository({required this.chatDao});

  Stream<List<Chat>> get chatsStream => chatDao.chatsStream;

  Future<List<Chat>> receiveAllChats() => chatDao.receiveChats();

  Future<void> insertChat(Chat chat) => chatDao.createChat(chat);

  Future<void> updateChat(Chat chat) => chatDao.updateChat(chat);

  Future<void> deleteChatById(String id) => chatDao.deleteChat(id);
}
