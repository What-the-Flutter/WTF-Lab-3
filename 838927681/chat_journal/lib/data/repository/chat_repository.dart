import 'dart:async';

import '../../domain/entities/chat.dart';
import '../../domain/repositories/api_chat_repository.dart';
import '../../domain/repositories/api_event_repository.dart';
import '../models/db_chat.dart';
import '../transformer/transformer.dart';
import 'api_provider/api_data_provider.dart';

class ChatRepository extends ApiChatRepository {
  final ApiDataProvider provider;
  final ApiEventRepository eventRepository;
  final chatsStreamController = StreamController<List<Chat>>();
  late final StreamSubscription<List<DBChat>> chatsStreamSubscription;

  ChatRepository({
    required this.provider,
    required this.eventRepository,
  }) {
    chatsStreamSubscription = provider.chatsStream.listen(
      (dbChats) {
        final chats = <Chat>[];
        for (final dbChat in dbChats) {
          chats.add(Transformer.dbChatToEntity(dbChat));
        }
        chats.sort((a, b) => a.lastDate.compareTo(b.lastDate));
        chatsStreamController.add(chats);
      },
    );
  }

  @override
  Stream<List<Chat>> get chatsStream => chatsStreamController.stream;

  @override
  Future<void> addChat(Chat chat) async {
    final dbChat = Transformer.chatToModel(chat);
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
    return chats;
  }

  @override
  Future<Chat> getChat(String id) async {
    final dbChat = await provider.getChat(id);
    final chat = Transformer.dbChatToEntity(dbChat);
    return chat;
  }

  @override
  Future<void> removeChat(Chat chat) async => await provider.deleteChat(
        Transformer.chatToModel(chat),
      );

  @override
  Future<void> updateChat(Chat chat) async => await provider.updateChat(
        Transformer.chatToModel(chat),
      );

  @override
  Future<void> updateLast(String id, String lastMessage, DateTime? lastDate,
      bool shouldCheck) async {
    var chat = await getChat(id);
    if (lastDate != null) {
      final shouldReplace = (chat.lastDate.compareTo(lastDate) < 0 ||
          chat.lastDate == chat.creationDate);
      if (shouldCheck) {
        if (shouldReplace) {
          chat = chat.copyWith(
            lastMessage: lastMessage,
            lastDate: lastDate,
          );
        }
      } else {
        chat = chat.copyWith(
          lastMessage: lastMessage,
          lastDate: lastDate,
        );
      }
    } else {
      chat =
          chat.copyWith(lastMessage: lastMessage, lastDate: chat.creationDate);
    }
    await provider.updateChat(Transformer.chatToModel(chat));
  }
}
