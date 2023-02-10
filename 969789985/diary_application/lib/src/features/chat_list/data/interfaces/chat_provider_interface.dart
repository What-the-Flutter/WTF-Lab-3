import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/chat_model.dart';

abstract class ChatProviderInterface {
  ValueStream<IList<ChatModel>> get allChats;

  Future<void> addChat(ChatModel chat);

  Future<void> updateChat(ChatModel chat);

  Future<void> removeChat(int id);
}
