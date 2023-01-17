part of 'move_messages_cubit.dart';

@freezed
class MoveMessagesState with _$MoveMessagesState {
  const factory MoveMessagesState.initial({
    required ChatViewList chats,
    required int amountOfMessages,
  }) = _InitialState;

  const factory MoveMessagesState.withSelected({
    required ChatViewList chats,
    required int amountOfMessages,
    required int selectedChatId,
  }) = _WithSelectedState;
}
