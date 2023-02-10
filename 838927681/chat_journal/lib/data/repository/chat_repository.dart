import '../../domain/entities/chat.dart';
import '../../domain/repositories/api_chat_repository.dart';
import '../provider/chat_provider.dart';
import '../transfromer/transformer.dart';
import 'event_repository.dart';

class ChatRepository extends ApiChatRepository {
  final provider = DataProvider();
  final eventRepository = EventRepository();
  static final chatsId = <int>{};

  @override
  Future<void> addChat(Chat chat) async {
    var id = 0;
    while (chatsId.contains(id)) {
      id++;
    }
    chatsId.add(id);
    final dbChat = Transformer.chatToModel(chat.copyWith(id: id));
    await provider.addChat(dbChat);
  }

  @override
  Future<List<Chat>> getChats() async {
    final dbChats = await provider.chats;
    final chats = List<Chat>.generate(
      dbChats.length,
      (index) {
        return Transformer.dbChatToEntity(dbChats[index]);
      },
    );
    for (var i = 0; i < chats.length; i++) {
      chatsId.add(chats[i].id);
      chats[i] = chats[i].copyWith(
        events: await eventRepository.getEvents(
          chats[i].id,
        ),
      );
    }
    chats.sort(
      (a, b) {
        return b.lastDate.compareTo(a.lastDate);
      },
    );
    return chats;
  }

  void _setIds(List<Chat> chats) {
    for (final chat in chats) {
      chatsId.add(chat.id);
    }
  }

  @override
  Future<void> removeChat(Chat chat) async => await provider.deleteChat(
        Transformer.chatToModel(chat),
      );

  @override
  Future<void> updateChat(Chat chat) async => await provider.updateChat(
        Transformer.chatToModel(chat),
      );
}
