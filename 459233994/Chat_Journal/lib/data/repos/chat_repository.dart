import '../../domain/entities/chat.dart';
import '../../domain/repos/chat_repository.dart';
import '../entities/chat_dto.dart';
import '../services/database_helper.dart';

class ChatRepositoryImpl extends ChatRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<List<Chat>> getChats() async {
    var raw = await databaseHelper.queryAllChats();
    return raw.map((f) => ChatDTO.fromJSON(f).toModel()).toList();
  }

  @override
  Future<void> insertChat(Chat chat) async {
    var chatDTO = ChatDTO(
      name: chat.name,
      createTime: chat.createTime,
      pageIcon: chat.pageIcon,
      isPinned: chat.isPinned,
    );
    databaseHelper.insertChat(chatDTO.toJson());
  }

  @override
  Future<void> changeChat(Chat chat) async {
    var chatDTO = ChatDTO(
      id: chat.id,
      name: chat.name,
      createTime: chat.createTime,
      pageIcon: chat.pageIcon,
      isPinned: chat.isPinned,
    );
    databaseHelper.updateChat(
      chat.id!,
      chatDTO.toJson(),
    );
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    databaseHelper.deleteChat(chat.id!);
  }
}
