import 'dart:async';

import '../entities/chat.dart';

abstract class ChatRepository{
  Future<List<Chat>> getChats();

  Future<void> insertChat(Chat chat);

  Future<void> changeChat(Chat chat);

  Future<void> deleteChat(Chat chat);

  Future<StreamSubscription> initListener();
}