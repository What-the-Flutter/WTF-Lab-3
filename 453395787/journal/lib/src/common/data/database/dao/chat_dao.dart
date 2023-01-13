import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../models/chat.dart';
import '../chat_database.dart';
import 'dao_api.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatTable])
class ChatDao extends DatabaseAccessor<ChatDatabase>
    with _$ChatDaoMixin, BaseDaoApi<ChatTableData, ChatTable> {
  ChatDao(ChatDatabase db) : super(db);

  @override
  TableInfo<ChatTable, ChatTableData> get table => chatTable;

  @override
  DatabaseAccessor get accessor => this;

  Future<int> addChatModel(Chat chat) async {
    return add(
      ChatTableCompanion.insert(
        name: chat.name,
        icon: chat.icon.codePoint,
        isPinned: chat.isPinned,
        creationDate: chat.creationDate,
      ),
    );
  }

  Chat transformToModel(ChatTableData chatTableData) {
    return Chat(
      id: chatTableData.uid,
      name: chatTableData.name,
      icon: IconData(
        chatTableData.icon,
        fontFamily: 'MaterialIcons',
      ),
      isPinned: chatTableData.isPinned,
      creationDate: chatTableData.creationDate,
    );
  }
}
