import 'package:rxdart/rxdart.dart';

import '../../models/db/db_chat.dart';
import '../../utils/typedefs.dart';

abstract class ChatProviderApi {
  ValueStream<DbChatList> get chats;

  Future<String> addChat(DbChat chat);

  Future<void> deleteChat(String chatId);

  Future<void> updateChat(DbChat chat);
}
