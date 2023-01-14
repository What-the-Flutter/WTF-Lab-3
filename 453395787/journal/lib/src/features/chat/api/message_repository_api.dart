import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/models/chat_view.dart';
import '../../../common/models/message.dart';
import '../../../common/models/tag.dart';

abstract class MessageRepositoryApi {
  ValueStream<ValueStream<IList<Message>>> get filteredChatStreams;

  ValueStream<IList<Tag>> get tags;

  ChatView get chat;

  Future<void> add(Message message);

  Future<void> customAdd(int chatId, Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> removeAll(IList<Message> messages);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);

  Future<void> search(String query, [IList<Tag>? tags]);
}
