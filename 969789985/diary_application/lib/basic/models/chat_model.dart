import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'message_model.dart';

class ChatModel {
  final int id;
  final String chatTitle;
  final MessageModel? lastMessage;
  final int chatIcon;
  final DateTime creationDate;
  final IList<MessageModel> messages;
  final bool isArchive;
  final bool isPinned;

  ChatModel({
    required this.id,
    required this.chatTitle,
    MessageModel? lastMessage,
    required this.chatIcon,
    DateTime? creationDate,
    required this.messages,
    this.isArchive = false,
    this.isPinned = false,
  })  : lastMessage = messages.isEmpty ? null : messages.last,
        creationDate = creationDate ?? DateTime.now();

  ChatModel copyWith({
    int? id,
    String? chatTitle,
    MessageModel? lastMessage,
    int? chatIcon,
    DateTime? creationDate,
    IList<MessageModel>? messages,
    bool? isArchive,
    bool? isPinned,
  }) {
    return ChatModel(
      id: id ?? this.id,
      chatTitle: chatTitle ?? this.chatTitle,
      lastMessage: lastMessage ?? this.lastMessage,
      chatIcon: chatIcon ?? this.chatIcon,
      creationDate: creationDate ?? this.creationDate,
      messages: messages ?? this.messages,
      isArchive: isArchive ?? this.isArchive,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
