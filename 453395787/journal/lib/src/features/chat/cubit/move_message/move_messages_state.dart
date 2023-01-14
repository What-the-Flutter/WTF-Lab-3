part of 'move_messages_cubit.dart';

@freezed
class MoveMessagesState with _$MoveMessagesState {
  const factory MoveMessagesState.initial({
    required IList<ChatView> chats,
    required int amountOfMessages,
  }) = _InitialState;

  const factory MoveMessagesState.withSelected({
    required IList<ChatView> chats,
    required int amountOfMessages,
    required int selectedChatId,
  }) = _WithSelectedState;
}
