import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../repositories/chat_repository.dart';

class ChatListProvider extends ChangeNotifier {
  final _repository = ChatRepository.get();

  ChatRepository get repository => _repository;

  void addChat(ChatModel chat) {
    _repository.chats = repository.chats.add(chat);
    notifyListeners();
  }

  void removeChat(ChatModel chat) {
    repository.chats = repository.chats.removeWhere(
      (el) => el.id == chat.id,
    );
    notifyListeners();
  }

  void update(ChatModel chat) {
    _repository.chats = _repository.chats.updateById(
      [chat],
      (item) => item.id,
    );
    notifyListeners();
  }

  ChatModel chatById(int id) =>
      _repository.chats.firstWhere((el) => el.id == id);
}
