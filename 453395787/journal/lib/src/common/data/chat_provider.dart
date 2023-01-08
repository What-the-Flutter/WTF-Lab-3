import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../api/chat_provider_api.dart';
import 'models/chat.dart';
import 'models/message.dart';
import 'models/tag.dart';

class ChatProvider extends ChatProviderApi {
  final BehaviorSubject<List<Chat>> _chatsStream =
      BehaviorSubject.seeded(_chats.entries.map((e) => e.value).toList());

  @override
  ValueStream<List<Chat>> getChats() {
    return _chatsStream.stream;
  }

  @override
  Future<void> saveChat(Chat chat) async {
    _chats[chat.id] = chat;
    _chatsStream.add(_chats.entries.map(((e) => e.value)).toList());
  }

  @override
  Future<void> deleteChat(int id) async {
    _chats.remove(id);
    _chatsStream.add(_chats.entries.map(((e) => e.value)).toList());
  }

  @override
  Future<void> loadData() async {
    _chatsStream.add(_chats.entries.map(((e) => e.value.copyWith(creationDate: DateTime.now()))).toList());
  }
}

Map<int, Chat> _chats = {
  0: Chat(
    id: 0,
    name: 'All',
    icon: Icons.all_inclusive_outlined,
    creationDate: DateTime.parse('2022-12-19 12:29:00'),
    isPinned: true,
    messages: IList(
      [
        Message(
          id: 1,
          dateTime: DateTime.parse('2022-12-19 12:30:00'),
          text: 'Hello',
        ),
        Message(
          id: 2,
          dateTime: DateTime.parse('2022-12-20 13:30:00'),
          text: 'Some long message',
        ),
        Message(
          id: 3,
          dateTime: DateTime.parse('2022-12-21 17:15:00'),
          text: 'Another message',
          isFavorite: true,
        ),
        Message(
          id: 4,
          dateTime: DateTime.parse('2022-12-21 17:16:24'),
          text: 'message with chips',
          tags: IList([
            const Tag(text: 'done', color: Colors.green),
            const Tag(text: 'important', color: Colors.orange),
            const Tag(text: 'work', color: Colors.purple),
          ]),
        ),
      ],
    ),
  ),
  1: Chat(
    id: 1,
    name: 'Sport',
    icon: Icons.sports_volleyball_outlined,
    creationDate: DateTime.parse('2022-12-21 21:01:00'),
    messages: IList(
      [
        Message(id: 1, text: 'Some Text'),
        Message(id: 2, text: 'Some Text'),
        Message(id: 3, text: 'Some Text'),
      ],
    ),
  ),
  2: Chat(
    id: 2,
    name: 'University',
    icon: Icons.science_outlined,
    creationDate: DateTime.parse('2022-11-11 11:11:00'),
    messages: IList(
      [
        Message(id: 1, text: 'Some Text'),
        Message(id: 2, text: 'Some Text'),
        Message(id: 3, text: 'Some Text'),
      ],
    ),
  ),
  3: Chat(
    id: 3,
    name: 'Other',
    icon: Icons.stadium_outlined,
    creationDate: DateTime.parse('2022-12-28 17:01:00'),
    messages: IList(
      [
        Message(id: 1, text: 'Some Text'),
        Message(id: 2, text: 'Some Text'),
        Message(id: 3, text: 'Some Text'),
      ],
    ),
  ),
};
