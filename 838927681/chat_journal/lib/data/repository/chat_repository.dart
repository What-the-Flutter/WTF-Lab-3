import 'dart:async';

import '../../domain/entities/chat.dart';
import '../../domain/repositories/api_chat_repository.dart';
import '../../domain/repositories/api_event_repository.dart';
import '../models/db_chat.dart';
import '../transformer/transformer.dart';
import 'api_provider/api_data_provider.dart';

class ChatRepository extends ApiChatRepository {
  final ApiDataProvider _provider;
  final ApiEventRepository _eventRepository;

  ChatRepository({
    required ApiDataProvider provider,
    required ApiEventRepository eventRepository,
  })  : _provider = provider,
        _eventRepository = eventRepository;

  @override
  Stream<List<Chat>> get chatsStream =>
      _provider.chatsStream.map<List<Chat>>(_transformToListChat);

  List<Chat> _transformToListChat(List<DBChat> dbChats) {
    final result = <Chat>[];
    for (final dbChat in dbChats) {
      result.add(Transformer.dbChatToEntity(dbChat));
    }
    return result;
  }

  @override
  Future<void> addChat(Chat chat) async {
    final dbChat = Transformer.chatToModel(chat);
    await _provider.addChat(dbChat);
  }

  @override
  Future<List<Chat>> getChats() async {
    final dbChats = await _provider.chats;
    final chats = List<Chat>.generate(dbChats.length, (index) {
      return Transformer.dbChatToEntity(dbChats[index]);
    });
    chats.sort((a, b) => b.lastDate.compareTo(a.lastDate));
    return chats;
  }

  @override
  Future<Chat> getChat(String id) async {
    final dbChat = await _provider.getChat(id);
    final chat = Transformer.dbChatToEntity(dbChat);
    return chat;
  }

  @override
  Future<void> removeChat(Chat chat) async => await _provider.deleteChat(
        Transformer.chatToModel(chat),
      );

  @override
  Future<void> updateChat(Chat chat) async => await _provider.updateChat(
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
    await _provider.updateChat(Transformer.chatToModel(chat));
  }
}
