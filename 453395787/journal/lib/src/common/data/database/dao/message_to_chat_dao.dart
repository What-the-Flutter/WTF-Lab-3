import 'package:drift/drift.dart';

import '../chat_database.dart';
import 'base_dao.dart';

part 'message_to_chat_dao.g.dart';

@DriftAccessor(tables: [
  MessageToChatTable,
])
class MessageToChatDao extends DatabaseAccessor<ChatDatabase>
    with
        _$MessageToChatDaoMixin,
        BaseDao<MessageToChatTableData, MessageToChatTable> {
  MessageToChatDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<MessageToChatTable, MessageToChatTableData> get table =>
      messageToChatTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addRelation({
    required int chatId,
    required int messageId,
  }) async {
    return add(
      MessageToChatTableCompanion.insert(
        chatId: chatId,
        messageId: messageId,
      ),
    );
  }
}
