import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' as material;
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../api/chat_provider_api.dart';
import '../../models/chat.dart';
import '../../models/message.dart';
import '../../models/tag.dart';
import 'dao/daos.dart';

part 'chat_database.g.dart';

part 'table/chat_table.dart';

part 'table/image_table.dart';

part 'table/image_to_message_table.dart';

part 'table/message_table.dart';

part 'table/message_to_chat_table.dart';

part 'table/tag_table.dart';

part 'table/tag_to_message_table.dart';

@DriftDatabase(
  tables: [
    ChatTable,
    MessageTable,
    MessageToChatTable,
    TagTable,
    TagToMessageTable,
    ImageTable,
    ImageToMessageTable,
  ],
  daos: [
    ChatDao,
    MessageDao,
    MessageToChatDao,
    TagDao,
    TagToMessageDao,
    ImageDao,
    ImageToMessageDao,
  ],
)
class ChatDatabase extends _$ChatDatabase implements ChatProviderApi {
  ChatDatabase() : super(_openConnection());

  static final Logger log = Logger(
    printer: PrettyPrinter(
      methodCount: 7,
    ),
  );

  @override
  int get schemaVersion => 1;

  @override
  Future<void> addChat(Chat chat) async {
    final chatId = await chatDao.addChatModel(chat);

    for (var message in chat.messages) {
      final messageId = await messageDao.addMessageModel(message);

      await messageToChatDao.addRelation(
        chatId: chatId,
        messageId: messageId,
      );

      for (var tag in message.tags) {
        final tagId = await tagDao.addTagModel(tag);
        await tagToMessageDao.addRelation(
          messageId: messageId,
          tagId: tagId,
        );
      }

      for (var image in message.images) {
        final imageId = await imageDao.addImageModel(image);

        await imageToMessageDao.addRelation(
          messageId: messageId,
          imageId: imageId,
        );
      }
    }
  }

  @override
  Future<void> addChats(IList<Chat> chats) async {
    chats.forEach(await addChat);
  }

  @override
  Future<void> deleteChat(int id) async {
    // delete chat
    final chat = await chatDao.firstWhere((tbl) => tbl.uid.equals(id));
    if (chat == null) return;
    await chatDao.deleteWhere((tbl) => tbl.uid.equals(chat.uid));

    // delete messages to chat
    final messagesToChat = await messageToChatDao.where(
      (tbl) => tbl.chatId.equals(id),
    );
    final messagesToChatIds = messagesToChat.map((e) => e.uid);
    messageToChatDao.deleteWhere(
      (tbl) => tbl.uid.isIn(messagesToChatIds),
    );

    // delete messages
    final messages = await getMessages(id);
    final messagesIds = messages.map((e) => e.uid);
    await messageDao.deleteWhere(
      (tbl) => tbl.uid.isIn(messagesIds),
    );

    // delete tags to messages
    final tagsToMessage = await tagToMessageDao.where(
      (e) => e.messageId.isIn(messagesIds),
    );
    final tagsToMessageIds = tagsToMessage.map((e) => e.uid);
    tagToMessageDao.deleteWhere(
      (tbl) => tbl.uid.isIn(tagsToMessageIds),
    );

    var images = IList<ImageTableData>([]);
    for (var message in messages) {
      images = images.addAll(
        await getImages(message.uid),
      );
    }

    // delete images to message
    final imagesToMessage = await imageToMessageDao.where(
      (image) => image.uid.isIn(
        messagesIds,
      ),
    );
    final imagesToMessageIds = imagesToMessage.map((e) => e.uid);
    await imageToMessageDao.deleteWhere(
      (tbl) => tbl.uid.isIn(imagesToMessageIds),
    );

    // delete images if not used anywhere else
    var imagesIds = images.map((image) => image.uid);
    final imagesToOtherMessages =
        await imageToMessageDao.where((image) => image.uid.isIn(imagesIds));
    final imagesToOtherMessagesIds =
        imagesToOtherMessages.map((image) => image.uid);
    for (var image in images) {
      if (!imagesToOtherMessagesIds.contains(image.uid)) {
        await imageDao.deleteWhere(
          (tbl) => tbl.uid.equals(image.uid),
        );
      }
    }
  }

  @override
  Future<void> deleteChats(IList<int> ids) async {
    ids.forEach(await deleteChat);
  }

  @override
  Future<Chat?> getChat(int id) async {
    var chat = await chatDao.firstWhere(
      (tbl) => tbl.uid.equals(id),
    );
    if (chat == null) return null;

    var messages = await getMessages(chat.uid);
    if (messages.isEmpty) {
      return chatDao.transformToModel(chat);
    }

    var modelMessages = IList<Message>([]);
    for (var message in messages) {
      var tags = await getTags(message.uid);
      var images = await getImages(message.uid);

      modelMessages = modelMessages.add(
        messageDao.transformToMessage(message).copyWith(
              images: images.map((image) => image.path).toIList(),
              tags: tags.map(tagFromTable).toIList(),
            ),
      );
    }

    return chatDao.transformToModel(chat).copyWith(
          messages: modelMessages,
        );
  }

  Future<IList<MessageTableData>> getMessages(int chatId) async {
    final messagesToChats = await messageToChatDao.where(
      (tbl) => tbl.chatId.equals(chatId),
    );
    final messagesId = messagesToChats.map(
      (e) => e.messageId,
    );

    return messageDao.where((tbl) => tbl.uid.isIn(messagesId));
  }

  Future<IList<TagTableData>> getTags(int messageId) async {
    final tagsToMessages = await tagToMessageDao.where(
      (tbl) => tbl.messageId.equals(messageId),
    );
    final tagsId = tagsToMessages.map(
      (e) => e.tagId,
    );

    return tagDao.where(
      (tbl) => tbl.uid.isIn(tagsId),
    );
  }

  Future<IList<ImageTableData>> getImages(int messageId) async {
    final imagesToMessages = await imageToMessageDao.where(
      (tbl) => tbl.messageId.equals(messageId),
    );
    final imagesId = imagesToMessages.map(
      (e) => e.imageId,
    );

    return imageDao.where(
      (tbl) => tbl.uid.isIn(imagesId),
    );
  }

  Tag tagFromTable(TagTableData tag) {
    return Tag(
      text: tag.content,
      color: material.Color(
        tag.color,
      ),
    );
  }

  @override
  Future<IList<Chat>> getChats() async {
    final chatsId = (await chatDao.get()).map(
      (chat) => chat.uid,
    );
    var chats = IList<Chat>([]);

    for (var id in chatsId) {
      chats = await chats.add(
        (await getChat(id))!,
      );
    }

    return chats;
  }

  @override
  Future<void> updateChat(Chat chat) async {
    // TODO make it good
    await deleteChat(chat.id);
    await addChat(chat);
  }

  @override
  Future<void> updateChats(IList<Chat> chats) async {
    chats.forEach(await updateChat);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      path.join(dbFolder.path, 'db2.sqlite'),
    );
    return NativeDatabase.createInBackground(file);
  });
}
