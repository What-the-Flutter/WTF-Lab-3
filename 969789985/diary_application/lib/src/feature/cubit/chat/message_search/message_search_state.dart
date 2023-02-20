part of 'message_search_cubit.dart';

@freezed
class MessageSearchState with _$MessageSearchState {
  const MessageSearchState._();

  const factory MessageSearchState.defaultMode({
    required IList<MessageModel> messages,
  }) = _DefaultMode;

  const factory MessageSearchState.searchActive({
    required IList<MessageModel> messages,
    required String query,
  }) = _SearchActive;

}
