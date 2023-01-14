import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_view.freezed.dart';

@freezed
class ChatView with _$ChatView {
  const factory ChatView({
    required int id,
    required String name,
    required IconData icon,
    required String messagePreview,
    required DateTime messagePreviewCreationTime,
    required int messageAmount,
    required bool isPinned,
    required DateTime creationDate,
  }) = _ChatView;
}
