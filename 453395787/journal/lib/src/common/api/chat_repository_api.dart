import 'package:rxdart/rxdart.dart';

import '../models/chat_view.dart';
import '../utils/typedefs.dart';

abstract class ChatRepositoryApi {
  ValueStream<ChatViewList> get chats;

  Future<void> add(ChatView chat);

  Future<void> update(ChatView chat);

  Future<void> remove(ChatView chat);

  Future<void> pin(ChatView chat);

  Future<void> unpin(ChatView chat);

  Future<void> togglePin(ChatView chat);
}
