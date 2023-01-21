import 'package:rxdart/rxdart.dart';

import '../../models/db/db_message.dart';
import '../../utils/typedefs.dart';

abstract class MessageProviderApi {
  ValueStream<DbMessageList> messagesOf({required Id chatId});

  Future<Id> addMessage(Id chatId, DbMessage message);

  Future<void> deleteMessage(Id messageId);

  Future<void> deleteMessages(Iterable<Id> messagesId);

  Future<void> updateMessage(DbMessage message);
}
