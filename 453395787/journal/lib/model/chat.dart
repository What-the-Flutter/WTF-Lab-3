import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class Chat {
  final int id;
  final String name;
  final IconData icon;
  final DateTime creationDate;
  final bool isPinned;
  final IList<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.icon,
    bool? isPinned,
    DateTime? creationDate,
    required this.messages,
  })  : isPinned = isPinned ?? false,
        creationDate = creationDate ?? DateTime.now();

  Message? get lastMessage => messages.isEmpty ? null : messages.first;

  Chat copyWith({
    int? id,
    String? name,
    IconData? icon,
    IList<Message>? messages,
    bool? isPinned,
    DateTime? creationDate,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      messages: messages ?? this.messages,
      isPinned: isPinned ?? this.isPinned,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
