part of 'message_search_cubit.dart';

@freezed
class MessageSearchState with _$MessageSearchState {
  const MessageSearchState._();

  const factory MessageSearchState.defaultMode({
    required IList<MessageModel> messages,
    required bool isSearchMode,
  }) = _DefaultMode;

  const factory MessageSearchState.searchActive({
    required IList<MessageModel> messages,
    required bool isSearchMode,
    required String query,
  }) = _SearchActive;

}
