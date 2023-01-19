part of 'move_messages_cubit.dart';

@freezed
class MoveMessagesState with _$MoveMessagesState {
  const factory MoveMessagesState.initial({
    required ChatViewList chats,
    required int amountOfMessages,
  }) = _InitialState;

  const factory MoveMessagesState.hasSelectedState({
    required ChatViewList chats,
    required int amountOfMessages,
    required Id selectedChatId,
  }) = _HasSelectedState;
}
