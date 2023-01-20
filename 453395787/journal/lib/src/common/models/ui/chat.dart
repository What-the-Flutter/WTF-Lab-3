import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/typedefs.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    @Default('') Id id,
    @Default('') String name,
    required IconData icon,
    @Default(false) bool isPinned,
    required DateTime creationDate,
    @Default('') String messagePreview,
    required DateTime messagePreviewCreationTime,
    @Default(0) int messageAmount,
  }) = _Chat;
}
