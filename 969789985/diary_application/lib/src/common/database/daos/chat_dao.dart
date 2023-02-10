import 'package:drift/drift.dart';

import '../../../features/chat_list/domain/chat_model.dart';
import '../chat_database.dart';
import '../tables/chat_table.dart';
import 'base_dao.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [
  ChatTable,
])
class ChatDao extends DatabaseAccessor<ChatDatabase>
    with _$ChatDaoMixin, BaseDao<ChatTableData, ChatTable> {
  ChatDao(ChatDatabase db) : super(db) {
    init();
  }

  @override
  TableInfo<ChatTable, ChatTableData> get table => chatTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addChatModel(ChatModel chat) async {
    return add(
      ChatTableCompanion.insert(
        chatTitle: chat.chatTitle,
        chatIcon: chat.chatIcon,
        isPinned: chat.isPinned,
        isArchive: chat.isArchive,
        creationDate: chat.creationDate,
      ),
    );
  }

  ChatModel transformToModel(ChatTableData chatTableData) {
    return ChatModel(
      id: chatTableData.id,
      chatTitle: chatTableData.chatTitle,
      chatIcon: chatTableData.chatIcon,
      isPinned: chatTableData.isPinned,
      isArchive: chatTableData.isArchive,
      creationDate: chatTableData.creationDate,
    );
  }
}
