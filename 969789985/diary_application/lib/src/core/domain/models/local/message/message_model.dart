import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../tag/tag_model.dart';

part 'message_model.freezed.dart';

@freezed
class MessageModel with _$MessageModel {
  MessageModel._();

  factory MessageModel._internal({
    required String id,
    required String parentId,
    required String messageText,
    required DateTime sendDate,
    required IList<Future<File>> images,
    required IList<TagModel> tags,
    required bool isFavorite,
  }) = _MessageModel;

  factory MessageModel({
    String? id,
    String? parentId,
    String messageText = '',
    DateTime? sendDate,
    IList<Future<File>>? images,
    IList<TagModel>? tags,
    bool? isFavorite,
  }) =>
      MessageModel._internal(
        id: id ?? '_id',
        parentId: parentId ?? '_parent_id',
        messageText: messageText,
        sendDate: sendDate ?? DateTime.now(),
        images: images ?? const IListConst([]),
        tags: tags ?? const IListConst([]),
        isFavorite: isFavorite ?? false,
      );
}
