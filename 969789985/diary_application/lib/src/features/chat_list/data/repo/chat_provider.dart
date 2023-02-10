import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../chat/domain/message_model.dart';
import '../../domain/chat_model.dart';
import '../interfaces/chat_provider_interface.dart';

class ChatProvider extends ChatProviderInterface {
  @override
  Future<IList<ChatModel>> all() async => await _chats.values.toIList();

  @override
  Future<void> add(ChatModel chat) async {
    if (_chats.containsValue(chat.id)) return;
    _chats[chat.id] = chat;
  }

  @override
  Future<void> remove(int id) async {
    _chats.remove(id);
  }

  @override
  Future<ChatModel?> chatById(int id) async => _chats[id];

  @override
  Future<void> update(ChatModel chat) async {
    if (_chats.containsKey(chat.id)) {
      _chats[chat.id] = chat;
    }
  }

  final Map<int, ChatModel> _chats = {
    0: ChatModel(
      id: 0,
      chatTitle: 'Accounts',
      chatIcon: Icons.account_box_sharp.codePoint,
      messages: IList(
        [
          MessageModel(
              id: 0,
              messageText:
                  'This is where you can store your account information.')
        ],
      ),
    ),
    1: ChatModel(
      id: 1,
      chatTitle: 'Events',
      chatIcon: Icons.event.codePoint,
      messages: IList(
        [],
      ),
    ),
    2: ChatModel(
      id: 2,
      chatTitle: 'Sport',
      chatIcon: Icons.sports_baseball_outlined.codePoint,
      messages: IList(
        [],
      ),
    ),
  };
}
