import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/models/ui/chat.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/models/ui/tag.dart';
import '../../../common/utils/typedefs.dart';

abstract class MessageRepositoryApi {
  ValueStream<IList<Message>> get messages;

  Chat get chat;

  ValueStream<IList<Tag>> get tags;

  Future<void> add(Message message);

  Future<void> customAdd(Id chatId, Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> removeAll(IList<Message> messages);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);

  Future<void> search(String query, [IList<Tag>? tags]);
}
