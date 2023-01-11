part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultMode({
    required Message message,
    @Default(false) bool isTagMenuOpened,
  }) = _DefaultMode;

  const factory MessageInputState.editMode({
    required Message message,
  }) = _EditMode;

  bool get canBeSent {
    return message.text.isNotEmpty ||
        message.images.isNotEmpty ||
        message.tags.isNotEmpty;
  }
}
