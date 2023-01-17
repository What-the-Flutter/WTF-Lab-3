import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../models/message.dart';
import '../models/tag.dart';
import '../utils/typedefs.dart';

abstract class MessageProviderApi {
  ValueStream<MessageList> messagesOf({required int chatId});

  ValueStream<TagList> get tags;

  Future<int> addMessage(int chatId, Message message);

  Future<void> deleteMessage(int messageId);

  Future<void> deleteMessages(IList<int> messagesId);

  Future<void> updateMessage(Message message);

  Future<int> addTag(Tag tag);

  Future<void> deleteTag(int tagId);

  Future<void> updateTag(Tag tag);
}
