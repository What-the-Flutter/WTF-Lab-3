import 'dart:async';

import 'package:diary_application/data/converter/converter_db.dart';
import 'package:diary_application/data/entities/chat_db.dart';
import 'package:diary_application/data/provider/api_firebase_provider.dart';
import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/repository/chat_repository_api.dart';
import 'package:diary_application/domain/repository/event_repository_api.dart';

class ChatRepository extends ChatRepositoryApi {
  final ApiDataProvider _provider;
  final EventRepositoryApi _eventRepository;

  ChatRepository({
    required ApiDataProvider provider,
    required EventRepositoryApi eventRepository,
  })  : _provider = provider,
        _eventRepository = eventRepository;

  @override
  Stream<List<Chat>> get chatsStream =>
      _provider.chatsStream.map<List<Chat>>(_dbList2chats).asBroadcastStream();

  List<Chat> _dbList2chats(List<ChatDB> dbChats) {
    final result = <Chat>[];
    for (final dbChat in dbChats) {
      result.add(ConverterDB.entity2Chat(dbChat));
    }
    return result;
  }

  @override
  Future<void> addChat(Chat chat) async {
    final dbChat = ConverterDB.chat2Entity(chat);
    await _provider.addChat(dbChat);
  }

  @override
  Future<void> changeChat(Chat chat) async {
    await _provider.updateChat(ConverterDB.chat2Entity(chat));
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    await _provider.deleteChat(ConverterDB.chat2Entity(chat));
  }

  @override
  Future<List<Chat>> getChats() async {
    final chatsDB = await _provider.chats;
    chatsDB.sort((b, a) => a.isPin.compareTo(b.isPin));
    return List<Chat>.generate(chatsDB.length, (index) {
      return ConverterDB.entity2Chat(chatsDB[index]);
    });
  }

  @override
  Future<Chat> getChat(String id) async {
    final chatDB = await _provider.getChat(id);
    final chat = ConverterDB.entity2Chat(chatDB);
    return chat;
  }

  @override
  Future<void> updateLastChat(
    String id,
    String? lastEvent,
    String? eventTime,
    bool check,
  ) async {
    Chat chat = await getChat(id);
    if (eventTime != null) {
      final shouldReplace = (chat.creationTime.compareTo(eventTime) < 0 ||
          chat.creationTime == chat.creationTime);
      if (check) {
        if (shouldReplace) {
          chat = chat.copyWith(
            lastEvent: lastEvent,
            lastUpdate: eventTime,
          );
        }
      } else {
        chat = chat.copyWith(
          lastEvent: lastEvent,
          lastUpdate: eventTime,
        );
      }
    } else {
      chat = chat.copyWith(lastEvent: lastEvent, lastUpdate: chat.creationTime);
    }
    await _provider.updateChat(ConverterDB.chat2Entity(chat));
  }
}
