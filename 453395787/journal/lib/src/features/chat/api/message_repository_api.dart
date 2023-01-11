import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/models/chat.dart';
import '../../../common/models/message.dart';
import '../../../common/models/tag.dart';

abstract class MessageRepositoryApi {
  ValueStream<ValueStream<Chat>> get filteredChatStreams;

  Future<void> loadData();

  Future<void> add(Message message);

  Future<void> update(Message message);

  Future<void> remove(Message message);

  Future<void> addToFavorites(Message message);

  Future<void> removeFromFavorites(Message message);

  Future<void> search(String query, [IList<Tag>? tags]);
}
