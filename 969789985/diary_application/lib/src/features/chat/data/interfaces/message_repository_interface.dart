import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/tag_model.dart';
import '../../domain/message_model.dart';

abstract class MessageRepositoryInterface {
  ValueStream<ValueStream<IList<MessageModel>>> get rxChatStreams;

  ValueStream<IList<TagModel>> get tags;

  Future<void> addMessage(MessageModel message);

  Future<int> updateMessage(MessageModel message);

  Future<void> deleteMessage(MessageModel message);

  Future<void> deleteSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  );

  Future<void> addToFavorites(MessageModel message);

  Future<void> removeFromFavorites(MessageModel message);

  Future<void> addTag(TagModel tag);

  Future<void> removeTag(TagModel tag);
}
