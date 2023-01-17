import 'package:rxdart/rxdart.dart';

import '../../../common/models/chat_view.dart';
import '../../../common/models/message.dart';
import '../../../common/utils/typedefs.dart';

abstract class MessageRepositoryApi {
  ValueStream<ValueStream<MessageList>> get filteredChatStreams;

  ValueStream<TagList> get tags;

  ChatView get chat;

  Future<void> add(Message message);

  Future<void> customAdd(int chatId, Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> removeAll(MessageList messages);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);

  Future<void> search(String query, [TagList? tags]);
}
