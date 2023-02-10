import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/tag_model.dart';
import '../../domain/message_model.dart';

abstract class MessageProviderInterface {
  ValueStream<IList<MessageModel>> messages({required int chatId});

  ValueStream<IList<TagModel>> get tags;

  Future<int> addMessage(MessageModel message, int chatId);

  Future<int> updateMessage(MessageModel message);

  Future<void> deleteMessage(int messageId);

  Future<void> deleteSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  );

  Future<int> addTag(TagModel tag);

  Future<void> removeTag(TagModel tag);
}
