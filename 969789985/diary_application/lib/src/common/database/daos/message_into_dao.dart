import 'package:drift/drift.dart';

import '../chat_database.dart';
import '../tables/message_into_table.dart';
import 'base_dao.dart';

part 'message_into_dao.g.dart';

@DriftAccessor(tables: [
  MessageIntoTable,
])
class MessageIntoDao extends DatabaseAccessor<ChatDatabase>
    with
        _$MessageIntoDaoMixin,
        BaseDao<MessageIntoTableData, MessageIntoTable> {
  MessageIntoDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<MessageIntoTable, MessageIntoTableData> get table =>
      messageIntoTable;

  @override
  DatabaseAccessor<GeneratedDatabase> get accessor => this;

  Future<int> addForeignMessage({
    required int chatId,
    required int messageId,
  }) async {
    return add(
      MessageIntoTableCompanion.insert(
        chatId: chatId,
        messageId: messageId,
      ),
    );
  }
}
