import 'package:flutter/material.dart';

import 'chat_repository.dart';
import 'model/chat.dart';

class ChatListProvider extends ChangeNotifier {
  final ChatRepository _repository = ChatRepository.get();

  ChatRepository get repository => _repository;

  void add(Chat chat) {
    _repository.chats = repository.chats.add(chat);
    notifyListeners();
  }

  void remove(Chat chat) {
    repository.chats = repository.chats.removeWhere(
      (e) => e.id == chat.id,
    );
    notifyListeners();
  }

  void update(Chat chat) {
    _repository.chats = _repository.chats.updateById(
      [chat],
      (item) => item.id,
    );
    notifyListeners();
  }

  void togglePin(Chat chat) {
    _repository.chats = _repository.chats.updateById(
      [chat.copyWith(isPinned: !chat.isPinned)],
      (item) => item.id == chat.id,
    );
    notifyListeners();
  }

  Chat findById(int id) {
    return _repository.chats.firstWhere((e) => e.id == id);
  }
}
