part of 'move_messages_cubit.dart';

@freezed
class MoveMessagesState with _$MoveMessagesState {
  const factory MoveMessagesState.initial({
    required IList<Chat> chats,
    required int amountOfMessages,
  }) = _Initial;

  const factory MoveMessagesState.selected({
    required IList<Chat> chats,
    required int amountOfMessages,
    required int selectedChatId,
  }) = _Selected;
}
