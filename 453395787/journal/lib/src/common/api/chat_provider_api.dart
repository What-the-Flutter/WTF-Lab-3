import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../models/chat_view.dart';

abstract class ChatProviderApi {
  ValueStream<IList<ChatView>> get chats;

  Future<int> addChat(ChatView chat);

  Future<void> deleteChat(int chatId);

  Future<void> updateChat(ChatView chat);
}
