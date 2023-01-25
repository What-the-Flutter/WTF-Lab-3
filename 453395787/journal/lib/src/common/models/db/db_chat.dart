import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/typedefs.dart';

part 'db_chat.freezed.dart';

part 'db_chat.g.dart';

@freezed
class DbChat with _$DbChat {
  const factory DbChat({
    @Default('') String id,
    @Default('') String name,
    required int iconCodePoint,
    @Default(false) bool isPinned,
    required DateTime creationDate,
    @Default('') String messagePreview,
    required DateTime messagePreviewCreationTime,
    @Default(0) int messageAmount,
  }) = _DbChat;

  factory DbChat.fromJson(Map<String, Object?> json) =>
      _$DbChatFromJson(json);
}
