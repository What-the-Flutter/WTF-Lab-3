import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../models/message.dart';
import '../models/tag.dart';
import '../utils/typedefs.dart';

abstract class MessageProviderApi {
  ValueStream<MessageList> messagesOf({required Id chatId});

  ValueStream<TagList> get tags;

  Future<Id> addMessage(Id chatId, Message message);

  Future<void> deleteMessage(Id messageId);

  Future<void> deleteMessages(IList<Id> messagesId);

  Future<void> updateMessage(Message message);

  Future<Id> addTag(Tag tag);

  Future<void> deleteTag(Id tagId);

  Future<void> updateTag(Tag tag);
}
