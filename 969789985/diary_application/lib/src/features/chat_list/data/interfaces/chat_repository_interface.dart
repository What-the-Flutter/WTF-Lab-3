import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../chat/domain/message_model.dart';
import '../../domain/chat_model.dart';

abstract class ChatRepositoryInterface {
  ValueStream<IList<ChatModel>> get chats;

  Future<void> add(ChatModel chat);

  Future<void> update(ChatModel chat);

  Future<void> remove(ChatModel chat);

}