part of 'chat_overview_cubit.dart';

@freezed
class ChatOverviewState with _$ChatOverviewState {
  const factory ChatOverviewState({
    required IList<ChatView> chats,
  }) = _ChatOverviewState;
}
