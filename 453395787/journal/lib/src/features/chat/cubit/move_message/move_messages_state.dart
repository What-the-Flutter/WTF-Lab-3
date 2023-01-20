part of 'move_messages_cubit.dart';

@freezed
class MoveMessagesState with _$MoveMessagesState {
  const factory MoveMessagesState.initial({
    required IList<Chat> chats,
    required int amountOfMessages,
  }) = _InitialState;

  const factory MoveMessagesState.hasSelectedState({
    required IList<Chat> chats,
    required int amountOfMessages,
    required Id selectedChatId,
  }) = _HasSelectedState;
}
