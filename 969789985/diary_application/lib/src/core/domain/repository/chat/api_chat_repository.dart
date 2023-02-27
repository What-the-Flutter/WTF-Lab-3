import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/local/chat/chat_model.dart';

abstract class ApiChatRepository {
  ValueStream<IList<ChatModel>> get chats;

  Future<void> add(ChatModel chat);

  Future<void> update(ChatModel chat);

  Future<void> remove(ChatModel chat);
}