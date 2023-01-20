import 'package:rxdart/rxdart.dart';

import '../../models/db/db_chat.dart';
import '../../utils/typedefs.dart';

abstract class ChatProviderApi {
  ValueStream<ChatViewList> get chats;

  Future<Id> addChat(DbChat chat);

  Future<void> deleteChat(Id chatId);

  Future<void> updateChat(DbChat chat);
}