import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/models/tag_model.dart';

part 'message_model.freezed.dart';

@freezed
class MessageModel with _$MessageModel {
  MessageModel._();

  factory MessageModel._internal({
    required int id,
    required String messageText,
    required DateTime sendDate,
    required IList<String> images,
    required IList<TagModel> tags,
    required bool isFavorite,
  }) = _MessageModel;

  factory MessageModel({
    int? id,
    String messageText = '',
    DateTime? sendDate,
    IList<String>? images,
    IList<TagModel>? tags,
    bool? isFavorite,
  }) =>
      MessageModel._internal(
        id: id ?? Random().nextInt(10000),
        messageText: messageText,
        sendDate: sendDate ?? DateTime.now(),
        images: images ?? const IListConst([]),
        tags: tags ?? const IListConst([]),
        isFavorite: isFavorite ?? false,
      );
}
