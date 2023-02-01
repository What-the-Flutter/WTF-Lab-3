import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../chat_list/domain/chat_model.dart';
import '../../domain/message_model.dart';

abstract class MessageRepositoryInterface {
  ValueStream<ValueStream<ChatModel>> get rxChatStreams;

  Future<void> upload();

  Future<void> add(MessageModel message);

  Future<void> update(MessageModel message);

  Future<void> remove(MessageModel message);

  Future<void> removeSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  );

  Future<void> addToFavorites(MessageModel message);

  Future<void> removeFromFavorites(MessageModel message);
}
