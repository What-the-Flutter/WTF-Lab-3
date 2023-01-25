import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatRepository {
  static final _instance = ChatRepository._internal();

  factory ChatRepository.get() => _instance;

  ChatRepository._internal() {
    chats = [
      ChatModel(
        id: 0,
        chatTitle: 'Accounts',
        chatIcon: Icons.account_box_sharp.codePoint,
        messages: IList(
          [],
        ),
      ),
      ChatModel(
        id: 1,
        chatTitle: 'Events',
        chatIcon: Icons.event.codePoint,
        messages: IList(
          [],
        ),
      ),
      ChatModel(
        id: 3,
        chatTitle: 'Sport',
        chatIcon: Icons.sports_baseball_outlined.codePoint,
        messages: IList(
          [],
        ),
      ),
    ].lock;
  }

  late IList<ChatModel> chats;

}
