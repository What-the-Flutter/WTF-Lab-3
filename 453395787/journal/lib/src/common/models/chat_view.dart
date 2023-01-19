import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';

part 'chat_view.freezed.dart';

part 'chat_view.g.dart';

@freezed
class ChatView with _$ChatView {
  const factory ChatView({
    @Default('') Id id,
    @Default('') String name,
    required int iconCodePoint,
    @Default(false) bool isPinned,
    required DateTime creationDate,
    @Default('') String messagePreview,
    required DateTime messagePreviewCreationTime,
    @Default(0) int messageAmount,
  }) = _ChatView;

  factory ChatView.fromJson(Map<String, Object?> json) =>
      _$ChatViewFromJson(json);
}
