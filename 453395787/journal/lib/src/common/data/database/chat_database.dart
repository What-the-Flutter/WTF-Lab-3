import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/chat_provider_api.dart';
import '../../api/message_provider_api.dart';
import '../../models/chat_view.dart';
import '../../models/message.dart';
import '../../models/tag.dart';
import '../../utils/typedefs.dart';
import 'dao/dao.dart';

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
class ChatDatabase extends _$ChatDatabase
    implements ChatProviderApi, MessageProviderApi {
  ChatDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<void> close() async {
    chatDao.close();
    messageToChatDao.close();
    messageDao.close();
    tagToMessageDao.close();
    tagDao.close();
    imageToMessageDao.close();
    imageDao.close();
    await super.close();
  }

  @override
  ValueStream<ChatViewList> get chats => chatDao.stream
      .map((chats) => chats.map(chatViewFromTableData).toIList())
      .shareValueSeeded(
        chatDao.stream.value.map(chatViewFromTableData).toIList(),
      );

  ChatView chatViewFromTableData(ChatTableData data) {
    var chatView = chatDao.transformToModel(data);
    final messagesId = messageToChatDao.stream.value
        .where((e) => e.chatId == chatView.id)
        .map((e) => e.messageId);

    final messages = messageDao.stream.value
        .where((message) => messagesId.contains(message.uid))
        .toIList();

    if (messages.isEmpty) {
      return chatView;
    } else {
      final lastMessage = messages
          .sort((a, b) => a.creationDate.compareTo(b.creationDate))
          .last;

      return chatView.copyWith(
        messagePreview: lastMessage.content,
        messagePreviewCreationTime: lastMessage.creationDate,
        messageAmount: messages.length,
      );
    }
  }

  @override
  Future<int> addChat(ChatView chat) async {
    return chatDao.addChatModel(chat);
  }

  @override
  Future<void> deleteChat(int chatId) async {
    await chatDao.deleteWhere((tbl) => tbl.uid.equals(chatId));
    final messagesToChat = await messageToChatDao.where(
      (tbl) => tbl.chatId.equals(chatId),
    );
    final messageIds = messagesToChat.map(
      (e) => e.messageId,
    );

    await messageToChatDao.deleteWhere(
      (tbl) => tbl.messageId.isIn(messageIds),
    );
    await messageDao.deleteWhere(
      (tbl) => tbl.uid.isIn(messageIds),
    );
  }

  @override
  Future<void> updateChat(ChatView chat) async {
    await chatDao.updateWhere(
      ChatTableCompanion.insert(
        name: chat.name,
        icon: chat.icon.codePoint,
        isPinned: chat.isPinned,
        creationDate: chat.creationDate,
      ),
      (tbl) => tbl.uid.equals(chat.id),
    );
  }

  @override
  ValueStream<MessageList> messagesOf({
    required int chatId,
  }) {
    final mergeStream = MergeStream([
      chatDao.stream,
      messageToChatDao.stream,
      messageDao.stream,
      imageToMessageDao.stream,
      imageDao.stream,
      tagToMessageDao.stream,
      tagDao.stream,
    ]).asyncMap(
      (event) {
        return getMessages(chatId);
      },
    );
    return mergeStream.shareValueSeeded(
      cachedMessages(chatId),
    );
  }

  Future<MessageList> getMessages(int chatId) async {
    final messagesToChat = await messageToChatDao.where(
      (tbl) => tbl.chatId.equals(chatId),
    );
    final messagesId = messagesToChat.map(
      (message) => message.uid,
    );

    final messages = await messageDao.where(
      (tbl) => tbl.uid.isIn(messagesId),
    );

    var modelMessages = MessageList([]);
    for (var message in messages) {
      var modelMessage = messageDao.transformToMessage(message);

      // find tags
      final tagsToMessage = await tagToMessageDao.where(
        (tbl) => tbl.messageId.equals(message.uid),
      );
      final tagsId = tagsToMessage.map(
        (tag) => tag.tagId,
      );
      final tags = (await tagDao.where((tbl) => tbl.uid.isIn(tagsId)))
          .map(tagDao.transformToModel);

      // find images
      final imagesToMessage = await imageToMessageDao.where(
        (tbl) => tbl.messageId.equals(message.uid),
      );
      final imagesId = imagesToMessage.map(
        (image) => image.imageId,
      );
      final images = (await imageDao.where((tbl) => tbl.uid.isIn(imagesId)))
          .map((image) => image.path);

      modelMessages = modelMessages.add(
        modelMessage.copyWith(
          tags: tags.toIList(),
          images: images.toIList(),
        ),
      );
    }

    return modelMessages.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );
  }

  MessageList cachedMessages(int chatId) {
    final messagesToChat = messageToChatDao.stream.value.where(
      (tbl) => tbl.chatId == chatId,
    );
    final messagesId = messagesToChat.map(
      (message) => message.uid,
    );

    final messages = messageDao.stream.value.where(
      (tbl) => messagesId.contains(tbl.uid),
    );

    var modelMessages = MessageList([]);
    for (var message in messages) {
      var modelMessage = messageDao.transformToMessage(message);

      // find tags
      final tagsToMessage = tagToMessageDao.stream.value.where(
        (tbl) => tbl.messageId == message.uid,
      );
      final tagsId = tagsToMessage.map(
        (tag) => tag.tagId,
      );
      final tags = (tagDao.stream.value.where(
        (tbl) => tagsId.contains(tbl.uid),
      )).map(tagDao.transformToModel);

      // find images
      final imagesToMessage = imageToMessageDao.stream.value.where(
        (tbl) => tbl.messageId == message.uid,
      );
      final imagesId = imagesToMessage.map(
        (image) => image.imageId,
      );
      final images = imageDao.stream.value
          .where((tbl) => imagesId.contains(tbl.uid))
          .map((image) => image.path);

      modelMessages = modelMessages.add(
        modelMessage.copyWith(
          tags: tags.toIList(),
          images: images.toIList(),
        ),
      );
    }

    return modelMessages.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );
  }

  @override
  ValueStream<TagList> get tags => tagDao.stream
      .map(
        (tags) => tags.map(tagDao.transformToModel).toIList(),
      )
      .shareValueSeeded(
        tagDao.stream.value.map(tagDao.transformToModel).toIList(),
      );

  @override
  Future<int> addMessage(int chatId, Message message) async {
    // add message
    final messageId = await messageDao.addMessageModel(message);

    // link message to chat
    await messageToChatDao.addRelation(
      chatId: chatId,
      messageId: messageId,
    );

    // link tags with message
    final messageTagsId = message.tags.map(
      (tag) => tag.id,
    );
    for (var id in messageTagsId) {
      tagToMessageDao.addRelation(
        messageId: messageId,
        tagId: id!,
      );
    }

    // add images if not exists and link it to message
    final images = message.images;
    final messageImagesFromDB = await imageDao.where(
      (tbl) => tbl.path.isIn(images),
    );
    final messageImagesPaths = messageImagesFromDB.map(
      (e) => e.path,
    );
    for (var image in images) {
      final int imageId;
      if (messageImagesPaths.contains(image)) {
        imageId = messageImagesFromDB.firstWhere((e) => e.path == image).uid;
      } else {
        imageId = await imageDao.addImageModel(image);
      }
      await imageToMessageDao.addRelation(
        messageId: messageId,
        imageId: imageId,
      );
    }

    return messageId;
  }

  @override
  Future<int> addTag(Tag tag) async {
    return tagDao.addTagModel(tag);
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    // delete message
    await messageDao.deleteWhere(
      (tbl) => tbl.uid.equals(messageId),
    );

    // delete link chat-message
    await messageToChatDao.deleteWhere(
      (tbl) => tbl.messageId.equals(messageId),
    );

    // delete link tag-message
    await tagToMessageDao.deleteWhere(
      (tbl) => tbl.messageId.equals(messageId),
    );

    final messageImages = await imageToMessageDao.where(
      (tbl) => tbl.messageId.equals(messageId),
    );
    // delete link image-message
    await imageToMessageDao.deleteWhere(
      (tbl) => tbl.messageId.equals(messageId),
    );
    for (var image in messageImages) {
      // delete images if not used in other messages
      final hasOtherLinks = await imageToMessageDao.firstWhere(
            (tbl) => tbl.imageId.equals(image.uid),
          ) !=
          null;

      if (!hasOtherLinks) {
        imageDao.deleteWhere(
          (tbl) => tbl.uid.equals(image.imageId),
        );
      }
    }
  }

  @override
  Future<void> deleteMessages(IList<int> messagesId) async {
    messagesId.forEach(await deleteMessage);
  }

  @override
  Future<void> deleteTag(int tagId) async {
    await tagToMessageDao.deleteWhere(
      (tbl) => tbl.tagId.equals(tagId),
    );
    await tagDao.deleteWhere(
      (tbl) => tbl.uid.equals(tagId),
    );
  }

  @override
  Future<void> updateMessage(Message message) async {
    final messageToChat = await messageToChatDao.firstWhere(
      (tbl) => tbl.messageId.equals(message.id),
    );
    await messageToChatDao.deleteWhere(
      (tbl) => tbl.messageId.equals(message.id),
    );

    await deleteMessage(message.id);
    await addMessage(messageToChat!.chatId, message);
  }

  @override
  Future<void> updateTag(Tag tag) async {
    await tagDao.updateWhere(
      TagTableCompanion.insert(
        content: tag.text,
        color: tag.color.value,
      ),
      (tbl) => tbl.uid.equals(tag.id!),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      path.join(dbFolder.path, 'journal_db.sqlite'),
    );
    return NativeDatabase.createInBackground(file);
  });
}
