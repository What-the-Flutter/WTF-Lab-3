import 'package:drift/drift.dart';

import '../../../models/message.dart';
import '../chat_database.dart';
import 'base_dao.dart';

part 'message_dao.g.dart';

@DriftAccessor(tables: [
  MessageTable,
])
class MessageDao extends DatabaseAccessor<ChatDatabase>
    with _$MessageDaoMixin, BaseDao<MessageTableData, MessageTable> {
  MessageDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<MessageTable, MessageTableData> get table => messageTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addMessageModel(Message message) async {
    return add(
      MessageTableCompanion.insert(
        content: message.text,
        creationDate: message.dateTime,
        isFavorite: message.isFavorite,
      ),
    );
  }

  Message transformToMessage(MessageTableData messageTableData) {
    return Message(
      id: messageTableData.uid,
      text: messageTableData.content,
      dateTime: messageTableData.creationDate,
      isFavorite: messageTableData.isFavorite,
    );
  }
}
