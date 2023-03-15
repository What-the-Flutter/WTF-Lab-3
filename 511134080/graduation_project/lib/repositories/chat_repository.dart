import '../dao/chat_dao.dart';
import '../models/chat.dart';

class ChatRepository {
  final chatDao = ChatDao();

  Future<List<Chat>> receiveAllChats() => chatDao.receiveChats();

  Future<int> insertChat(Chat chat) => chatDao.createChat(chat);

  Future<int> updateChat(Chat chat) => chatDao.updateChat(chat);

  Future<int> deleteChatById(String id) => chatDao.deleteChat(id);
}
