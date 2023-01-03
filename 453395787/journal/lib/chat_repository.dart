import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import 'model/chat.dart';
import 'model/message.dart';

class ChatRepository {
  static final ChatRepository _instance = ChatRepository._internal();

  factory ChatRepository.get() => _instance;

  ChatRepository._internal() {
    chats = [
      Chat(
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
            ),
          ],
        ),
      ),
      Chat(
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
      Chat(
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
      Chat(
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
    ].lock;
  }

  IList<Chat> chats = IList([]);

  IList<int> get chatOrder {
    return chats
        .whereMoveToTheStart((item) => item.isPinned)
        .map((item) => item.id)
        .toIList();
  }

  IList<Chat> get orderedChats {
    var chats = IList<Chat>([]);
    for (var id in chatOrder) {
      chats = chats.add(
        this.chats.firstWhere((e) => e.id == id),
      );
    }
    return chats;
  }
}
