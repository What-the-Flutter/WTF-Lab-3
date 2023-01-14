import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../models/chat_view.dart';

abstract class ChatRepositoryApi {
  ValueStream<IList<ChatView>> get chats;

  Future<void> add(ChatView chat);

  Future<void> update(ChatView chat);

  Future<void> remove(ChatView chat);

  Future<void> pin(ChatView chat);

  Future<void> unpin(ChatView chat);

  Future<void> togglePin(ChatView chat);
}
