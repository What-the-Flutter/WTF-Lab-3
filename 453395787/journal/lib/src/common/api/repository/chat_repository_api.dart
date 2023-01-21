import 'package:rxdart/rxdart.dart';

import '../../models/ui/chat.dart';
import '../../utils/typedefs.dart';

abstract class ChatRepositoryApi {
  ValueStream<ChatList> get chats;

  Future<void> add(Chat chat);

  Future<void> update(Chat chat);

  Future<void> remove(Chat chat);

  Future<void> pin(Chat chat);

  Future<void> unpin(Chat chat);

  Future<void> togglePin(Chat chat);
}
