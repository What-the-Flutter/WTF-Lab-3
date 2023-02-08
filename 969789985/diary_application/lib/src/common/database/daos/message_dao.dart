import 'dart:developer' as dev;

import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../features/chat/domain/message_model.dart';
import '../../models/tag_model.dart';
import '../chat_database.dart';
import '../images_converter.dart';
import '../tables/message_table.dart';
import '../tags_converter.dart';
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
  DatabaseAccessor<GeneratedDatabase> get accessor => this;

  Future<int> addMessageModel(MessageModel message) async {
    dev.log('${message.images}', name: 'IMAGESS');

    return add(
      MessageTableCompanion.insert(
        messageText: message.messageText,
        sendDate: message.sendDate,
        imagePaths: MessageImages(message.images),
        tags: MessageTags(
          message.tags.map((tag) => tag.id).toIList(),
          message.tags.map((tag) => tag.tagTitle).toIList(),
          message.tags.map((tag) => tag.tagIcon).toIList(),
        ),
        isFavorite: false,
      ),
    );
  }

  MessageModel fromJson(MessageTableData messageTableData) {
    final tags = <TagModel>[];

    for (var i = 0; i < messageTableData.tags.tagsIds.length; i++) {
      final id = messageTableData.tags.tagsIds[i];
      final tagTitle = messageTableData.tags.tagsTitles[i];
      final tagIcon = messageTableData.tags.tagsIcons[i];

      tags.add(
        TagModel(id: id, tagTitle: tagTitle, tagIcon: tagIcon),
      );
    }

    return MessageModel(
      id: messageTableData.id,
      messageText: messageTableData.messageText,
      sendDate: messageTableData.sendDate,
      images: messageTableData.imagePaths.paths,
      tags: tags.isEmpty ? IList<TagModel>([]) : tags.toIList(),
      isFavorite: messageTableData.isFavorite,
    );
  }
}
