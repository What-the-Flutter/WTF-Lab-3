import 'package:rxdart/rxdart.dart';

import '../../models/db/db_message.dart';
import '../../utils/typedefs.dart';

abstract class MessageProviderApi {
  ValueStream<DbMessageList> messagesOf({required String chatId});

  Future<String> addMessage(String chatId, DbMessage message);

  Future<void> deleteMessage(String messageId);

  Future<void> deleteMessages(Iterable<String> messagesId);

  Future<void> updateMessage(DbMessage message);
}
