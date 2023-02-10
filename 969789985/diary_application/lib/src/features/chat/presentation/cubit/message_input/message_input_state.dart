part of 'message_input_cubit.dart';

@freezed
class MessageInputState with _$MessageInputState {
  const MessageInputState._();

  const factory MessageInputState.defaultMode({
    required MessageModel message,
    required int sendIcon,
    required bool isTagOpened,
    required IMap<int, bool> tagSelected,
  }) = _DefaultMode;
}
