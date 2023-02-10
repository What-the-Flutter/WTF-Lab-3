part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultMode({
    required MessageModel message,
    required bool canSend,
    required bool isTagOpened,
    required IMap<int, bool> tagSelected,
    required bool tagRemoving,
  }) = _DefaultMode;
}
