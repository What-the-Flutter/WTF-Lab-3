part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultMode({
    required Message message,
  }) = _DefaultMode;

  const factory MessageInputState.editMode({
    required Message message,
  }) = _EditMode;

  bool get canBeSended {
    return message.text.isNotEmpty ||
        message.images.isNotEmpty ||
        message.tags.isNotEmpty;
  }
}
