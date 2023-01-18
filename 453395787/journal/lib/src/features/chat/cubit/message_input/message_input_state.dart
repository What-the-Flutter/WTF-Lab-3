part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultModeState({
    required Message message,
    @Default(false) bool isTagMenuOpened,
  }) = _DefaultModeState;

  const factory MessageInputState.editModeState({
    required Message message,
  }) = _EditModeState;

  bool get canBeSent {
    return message.text.isNotEmpty ||
        message.images.isNotEmpty;
  }
}
