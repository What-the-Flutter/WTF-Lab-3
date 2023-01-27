import 'package:rxdart/rxdart.dart';

import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/utils/typedefs.dart';

abstract class MessageRepositoryApi {
  ValueStream<MessageList> get messages;

  Chat get chat;

  ValueStream<TagList> get tags;

  Future<void> add(Message message);

  Future<void> addToOtherChat(String chatId, Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> removeAll(MessageList messages);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);

  Future<void> search(String query, [TagList? tags]);
}
