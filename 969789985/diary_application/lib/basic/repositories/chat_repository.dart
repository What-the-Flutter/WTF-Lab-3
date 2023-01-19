import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  static final _instance = ChatRepository._internal();

  factory ChatRepository.get() => _instance;

  ChatRepository._internal() {
    chats = [
      ChatModel(
        id: 0,
        chatTitle: 'Clear chat',
        chatIcon: Icons.ac_unit_outlined,
        messages: IList(
          [
            MessageModel(
              id: 0,
              messageText: 'Hello',
              sendDate: DateTime.now(),
              isFavorite: false,
            ),
            MessageModel(
              id: 1,
              messageText: 'Hello2',
              sendDate: DateTime.parse('2022-12-13 12:12:34'),
              isFavorite: false,
            ),
          ],
        ),
      ),
    ].lock;
  }

  late IList<ChatModel> chats;

}
