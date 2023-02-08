import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/chat/data/interfaces/message_provider_interface.dart';
import '../../features/chat/domain/message_model.dart';
import '../../features/chat_list/data/interfaces/chat_provider_interface.dart';
import '../../features/chat_list/domain/chat_model.dart';
import '../models/tag_model.dart';
import 'daos/daos.dart';
import 'images_converter.dart';
import 'tables/tables.dart';
import 'tags_converter.dart';

part 'chat_database.g.dart';

@DriftDatabase(
  tables: [
    ChatTable,
    MessageIntoTable,
    MessageTable,
    TagsTable,
  ],
  daos: [
    ChatDao,
    MessageIntoDao,
    MessageDao,
    TagsDao,
  ],
)
class ChatDatabase extends _$ChatDatabase
    implements ChatProviderInterface, MessageProviderInterface {
  ChatDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<void> close() async {
    chatDao.close();
    messageDao.close();
    messageIntoDao.close();
    tagsDao.close();
    await super.close();
  }

  @override
  ValueStream<IList<ChatModel>> get allChats => chatDao.stream
      .map((chats) => chats.map(chatViewFromTableData).toIList())
      .shareValueSeeded(
        chatDao.stream.value.map(chatViewFromTableData).toIList(),
      );

  ChatModel chatViewFromTableData(ChatTableData data) {
    var chatView = chatDao.transformToModel(data);
    final messagesId = messageIntoDao.stream.value
        .where((e) => e.chatId == chatView.id)
        .map((e) => e.messageId);

    final messages = messageDao.stream.value
        .where((message) => messagesId.contains(message.id))
        .toIList();

    if (messages.isEmpty) {
      return chatView;
    } else {
      return chatView;
    }
  }

  @override
  Future<void> addChat(ChatModel chat) async {
    await chatDao.addChatModel(chat);
  }

  @override
  Future<void> removeChat(int id) async {
    await chatDao.deleteWhere((tbl) => tbl.id.equals(id));

    final removableMessageIdsIntoChat = await messageIntoDao.where(
      (tbl) => tbl.chatId.equals(id),
    );

    final removableMessagesIds = removableMessageIdsIntoChat.map(
      (el) => el.id,
    );

    await messageIntoDao.deleteWhere(
      (tbl) => tbl.messageId.isIn(removableMessagesIds),
    );

    await messageDao.deleteWhere(
      (tbl) => tbl.id.isIn(removableMessagesIds),
    );
  }

  @override
  Future<void> updateChat(ChatModel chat) async {
    await chatDao.updateWhere(
      ChatTableCompanion.insert(
        chatTitle: chat.chatTitle,
        chatIcon: chat.chatIcon,
        isPinned: chat.isPinned,
        isArchive: chat.isArchive,
        creationDate: chat.creationDate,
      ),
      (tbl) => tbl.id.equals(chat.id),
    );
  }

  @override
  ValueStream<IList<MessageModel>> messages({required int chatId}) {
    final streams = MergeStream([
      chatDao.stream,
      messageDao.stream,
      messageIntoDao.stream,
      tagsDao.stream,
    ]).asyncMap(
      (event) => messagesOfChat(chatId),
    );

    return streams.shareValue();
  }

  Future<IList<MessageModel>> messagesOfChat(int chatId) async {
    final messagesInto = await messageIntoDao.where(
      (tbl) => tbl.chatId.equals(chatId),
    );

    final messagesId = messagesInto.map((element) => element.id);

    final messages = await messageDao.where((tbl) => tbl.id.isIn(messagesId));

    var messagesMutableList = IList<MessageModel>([]);

    for (final message in messages) {
      final mes = messageDao.fromJson(message);

      messagesMutableList = messagesMutableList.add(mes);
    }
    return messagesMutableList;
  }

  @override
  ValueStream<IList<TagModel>> get tags => tagsDao.stream
      .map(
        (tag) => tag.map(tagsDao.fromJson).toIList(),
      )
      .shareValueSeeded(
        tagsDao.stream.value.map((tagsDao.fromJson)).toIList(),
      );

  @override
  Future<int> addMessage(MessageModel message, int chatId) async {
    final messageId = await messageDao.addMessageModel(message);

    await messageIntoDao.addForeignMessage(
      chatId: chatId,
      messageId: messageId,
    );

    return messageId;
  }

  @override
  Future<int> addTag(TagModel tag) async {
    return await tagsDao.addTag(tag);
  }

  @override
  Future<void> removeTag(TagModel tag) async {
    await tagsDao.deleteWhere(
      (tbl) => tbl.id.equals(tag.id),
    );
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    await messageDao.deleteWhere(
      (tbl) => tbl.id.equals(messageId),
    );

    await messageIntoDao.deleteWhere(
      (tbl) => tbl.messageId.equals(messageId),
    );
  }

  @override
  Future<void> deleteSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  ) async {
    for (final message in messages) {
      if (selected.containsKey(message.id) && selected[message.id]!) {
        deleteMessage(message.id);
      }
    }
  }

  @override
  Future<int> updateMessage(MessageModel message) async {
    return (messageDao.update(messageTable)
          ..where((tbl) => tbl.id.equals(message.id)))
        .write(
      MessageTableCompanion(
        messageText: Value(message.messageText),
        isFavorite: Value(message.isFavorite),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'diary_application_db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
