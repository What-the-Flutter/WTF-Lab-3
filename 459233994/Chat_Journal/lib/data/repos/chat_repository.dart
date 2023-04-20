import 'dart:async';

import '../../domain/entities/chat.dart';
import '../../domain/repos/chat_repository.dart';
import '../entities/chat_dto.dart';
import '../services/database_service.dart';

class ChatRepositoryImpl extends ChatRepository {
  final DataBaseService _dataBaseService;
  late final StreamSubscription _streamSubscription;

  ChatRepositoryImpl({required dataBaseService})
      : _dataBaseService = dataBaseService;

  @override
  void initListener(Function updateChats) async {
    _streamSubscription = await _dataBaseService.initListenerChats(updateChats);
  }

  @override
  Future<List<Chat>> getChats() async {
    final keys = <String>[];
    final raw = await _dataBaseService.queryAllChats(keys);
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
    _dataBaseService.insertChat(chatDTO.toJson());
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
    _dataBaseService.updateChat(
      chat.id!,
      chatDTO.toJson(),
    );
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    _dataBaseService.deleteChat(chat.id!);
  }

  @override
  void disposeListener() {
    _streamSubscription.cancel();
  }
}
