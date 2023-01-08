import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  Chat._();

  factory Chat._internal({
    required int id,
    required String name,
    required IconData icon,
    required IList<Message> messages,
    required bool isPinned,
    required DateTime creationDate,
  }) = _Chat;

  factory Chat({
    int? id,
    String name = '',
    required IconData icon,
    IList<Message>? messages,
    bool isPinned = false,
    DateTime? creationDate,
  }) =>
      Chat._internal(
        id: id ?? Random().nextInt(10000),
        name: name,
        icon: icon,
        messages: messages ?? const IListConst([]),
        isPinned: isPinned,
        creationDate: creationDate ?? DateTime.now(),
      );

  Message? get lastMessage => messages.isEmpty ? null : messages.last;
}
