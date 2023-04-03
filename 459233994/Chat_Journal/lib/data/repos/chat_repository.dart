import '../../domain/entities/chat.dart';
import '../../domain/repos/chat_repository.dart';
import '../entities/chat_dto.dart';
import '../services/database_service.dart';

class ChatRepositoryImpl extends ChatRepository {
  final DataBaseService dataBaseService;

  ChatRepositoryImpl({required this.dataBaseService});

  @override
  void initListener(Function updateChats) {
    dataBaseService.databaseRef
        .child(dataBaseService.fireBaseAuth.currentUser!.uid)
        .child('chats')
        .onValue
        .listen(
      (event) {
        updateChats();
      },
    );
  }

  @override
  Future<List<Chat>> getChats() async {
    final keys = <String>[];
    final raw = await dataBaseService.queryAllChats(keys);
    final chats = raw.map((chat) => ChatDTO.fromJSON(chat).toModel()).toList();
    for (var i = 0; i < chats.length; i++) {
      chats[i] = chats[i].copyWith(id: keys[i]);
    }
    return chats;
  }

  @override
  Future<void> insertChat(Chat chat) async {
    final chatDTO = ChatDTO(
      name: chat.name,
      createTime: chat.createTime,
      pageIcon: chat.pageIcon,
      isPinned: chat.isPinned,
    );
    dataBaseService.insertChat(chatDTO.toJson());
  }

  @override
  Future<void> changeChat(Chat chat) async {
    final chatDTO = ChatDTO(
      id: chat.id,
      name: chat.name,
      createTime: chat.createTime,
      pageIcon: chat.pageIcon,
      isPinned: chat.isPinned,
    );
    dataBaseService.updateChat(
      chat.id!,
      chatDTO.toJson(),
    );
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    dataBaseService.deleteChat(chat.id!);
  }
}
