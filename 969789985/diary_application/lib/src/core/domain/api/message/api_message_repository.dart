import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/local/message/message_model.dart';

abstract class ApiMessageRepository {
  ValueStream<IList<MessageModel>> get rxChatStreams;

  Future<void> addMessage(MessageModel message);

  Future<void> updateMessage(MessageModel message);

  Future<void> deleteMessage(MessageModel message);

  Future<void> deleteSelected(
    IList<MessageModel> messages,
  );

  Future<void> addToFavorites(IList<MessageModel> messages);

  Future<void> removeFromFavorites(IList<MessageModel> messages);
}
