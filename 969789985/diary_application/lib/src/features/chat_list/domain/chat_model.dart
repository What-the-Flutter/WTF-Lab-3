import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../chat/domain/message_model.dart';

part 'chat_model.freezed.dart';

@freezed
class ChatModel with _$ChatModel {
  ChatModel._();

  factory ChatModel._internal({
    required int id,
    required String chatTitle,
    required int chatIcon,
    required DateTime creationDate,
    required IList<MessageModel> messages,
    required bool isArchive,
    required bool isPinned,
  }) = _ChatModel;

  factory ChatModel({
    int? id,
    String chatTitle = '',
    required int chatIcon,
    DateTime? creationDate,
    IList<MessageModel>? messages,
    bool isArchive = false,
    bool isPinned = false,
  }) =>
      ChatModel._internal(
        id: id ?? Random().nextInt(10000),
        chatTitle: chatTitle,
        chatIcon: chatIcon,
        creationDate: creationDate ?? DateTime.now(),
        messages: messages ?? const IListConst([]),
        isPinned: isPinned,
        isArchive: isArchive,
      );

  MessageModel? get lastMessage => messages.lastOrNull;

}
