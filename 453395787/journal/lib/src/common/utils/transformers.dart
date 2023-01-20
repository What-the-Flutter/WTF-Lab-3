import 'dart:async';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../models/db/db_chat.dart';
import '../models/db/db_message.dart';
import '../models/db/db_tag.dart';
import '../models/ui/chat.dart';
import '../models/ui/message.dart';
import '../models/ui/tag.dart';
import 'typedefs.dart';

typedef FetchFileCallback = Future<File> Function(Id id);
typedef GetTagCallback = Tag Function(Id id);

abstract class Transformers {
  static final modelsToTagsStreamTransformer =
      StreamTransformer<IList<DbTag>, IList<Tag>>.fromHandlers(
    handleData: (models, sink) {
      sink.add(
        Transformers.modelsToTags(models),
      );
    },
  );

  static IList<Tag> modelsToTags(IList<DbTag> models) {
    return models.map(modelToTag).toIList();
  }

  static Tag modelToTag(DbTag model) {
    return Tag(
      id: model.id,
      text: model.text,
      color: Color(
        model.colorCode,
      ),
    );
  }

  static DbTag tagToModel(Tag tag) {
    return DbTag(
      id: tag.id,
      text: tag.text,
      colorCode: tag.color.value,
    );
  }

  static final modelsToChatsStreamTransformer =
      StreamTransformer<IList<DbChat>, IList<Chat>>.fromHandlers(
    handleData: (value, sink) {
      sink.add(
        Transformers.modelsToChats(value),
      );
    },
  );

  static IList<Chat> modelsToChats(IList<DbChat> chats) {
    return chats.map(modelToChat).toIList();
  }

  static Chat modelToChat(DbChat chat) {
    return Chat(
      id: chat.id,
      name: chat.name,
      icon: IconData(
        chat.iconCodePoint,
        fontFamily: 'MaterialIcons',
      ),
      isPinned: chat.isPinned,
      creationDate: chat.creationDate,
      messagePreview: chat.messagePreview,
      messagePreviewCreationTime: chat.messagePreviewCreationTime,
      messageAmount: chat.messageAmount,
    );
  }

  static DbChat chatToModel(Chat chat) {
    return DbChat(
      id: chat.id,
      name: chat.name,
      iconCodePoint: chat.icon.codePoint,
      isPinned: chat.isPinned,
      creationDate: chat.creationDate,
      messagePreview: chat.messagePreview,
      messagePreviewCreationTime: chat.messagePreviewCreationTime,
      messageAmount: chat.messageAmount,
    );
  }

  static StreamTransformer<IList<DbMessage>, IList<Message>>
      modelsToMessagesStreamTransformer(
    FetchFileCallback fetchFileCallback,
    GetTagCallback getTagCallback,
  ) {
    return StreamTransformer<IList<DbMessage>, IList<Message>>.fromHandlers(
      handleData: (models, sink) {
        sink.add(
          Transformers.modelsToMessages(
            models,
            fetchFileCallback,
            getTagCallback,
          ),
        );
      },
    );
  }

  static IList<Message> modelsToMessages(
    IList<DbMessage> models,
    FetchFileCallback fetchFileCallback,
    GetTagCallback getTagCallback,
  ) {
    return models
        .map(
          (model) => modelToMessage(
            model,
            fetchFileCallback,
            getTagCallback,
          ),
        )
        .toIList();
  }

  static Message modelToMessage(
    DbMessage model,
    FetchFileCallback fetchFileCallback,
    GetTagCallback getTagCallback,
  ) {
    return Message(
      id: model.id,
      parentId: model.parentId,
      text: model.text,
      dateTime: model.dateTime,
      images: model.images.map(fetchFileCallback).toIList(),
      tags: model.tagsId.map(getTagCallback).toIList(),
      isFavorite: model.isFavorite,
    );
  }

  static Future<DbMessage> messageToModel(Message message) async {
    var images = IList<String>([]);
    for (var image in message.images) {
      images = images.add(
        basename(
          (await image).path,
        ),
      );
    }

    return DbMessage(
      id: message.id,
      parentId: message.parentId,
      text: message.text,
      dateTime: message.dateTime,
      images: images,
      tagsId: message.tags.map((tag) => tag.id).toIList(),
      isFavorite: message.isFavorite,
    );
  }
}
