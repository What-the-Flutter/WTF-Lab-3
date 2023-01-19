import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import 'message_model.dart';

class ChatModel {
  ChatModel({
    required this.id,
    required this.chatTitle,
    MessageModel? lastMessage,
    required this.chatIcon,
    DateTime? creationDate,
    required this.messages,
  })  : lastMessage = messages.isEmpty ? null : messages.last,
        creationDate = creationDate ?? DateTime.now();


  final int id;
  final String chatTitle;
  final MessageModel? lastMessage;
  final IconData chatIcon;
  final DateTime creationDate;
  final IList<MessageModel> messages;

  ChatModel copyWith({
    int? id,
    String? chatTitle,
    MessageModel? lastMessage,
    IconData? chatIcon,
    DateTime? creationDate,
    IList<MessageModel>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      chatTitle: chatTitle ?? this.chatTitle,
      lastMessage: lastMessage ?? this.lastMessage,
      chatIcon: chatIcon ?? this.chatIcon,
      creationDate: creationDate ?? this.creationDate,
      messages: messages ?? this.messages,
    );
  }

}
