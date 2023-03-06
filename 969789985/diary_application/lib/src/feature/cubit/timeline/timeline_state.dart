part of 'timeline_cubit.dart';

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState.defaultMode({
    required IList<MessageModel> messages,
    required IList<ChatModel> chats,
    required String hashtag,
  }) = _DefaultMode;
}
