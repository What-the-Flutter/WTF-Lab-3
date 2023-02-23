part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultMode({
    required MessageModel message,
    required IList<TagModel> tags,
    required bool canSend,
  }) = _DefaultMode;

  const factory MessageInputState.tagMode({
    required MessageModel message,
    required IList<TagModel> tags,
    required IMap<String, bool> selectedTags,
    required bool removingMode,
  }) = _TagMode;
}
