import 'package:rxdart/rxdart.dart';

import '../data/models/chat.dart';

abstract class ChatProviderApi {
  ValueStream<List<Chat>> getChats();

  Future<void> loadData();

  Future<void> saveChat(Chat chat);

  Future<void> deleteChat(int id);
}
