import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../models/chat_view.dart';
import '../chat_database.dart';
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

  Future<int> addChatModel(ChatView chat) async {
    return add(
      ChatTableCompanion.insert(
        name: chat.name,
        icon: chat.icon.codePoint,
        isPinned: chat.isPinned,
        creationDate: chat.creationDate,
      ),
    );
  }

  ChatView transformToModel(ChatTableData chatTableData) {
    return ChatView(
      id: chatTableData.uid,
      name: chatTableData.name,
      icon: IconData(
        chatTableData.icon,
        fontFamily: 'MaterialIcons',
      ),
      isPinned: chatTableData.isPinned,
      creationDate: chatTableData.creationDate,
      messagePreview: '',
      messagePreviewCreationTime: chatTableData.creationDate,
      messageAmount: 0,
    );
  }
}
