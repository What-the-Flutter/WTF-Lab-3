part of 'timeline_cubit.dart';

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState.defaultMode({
    required IList<MessageModel> messages,
    required IList<MessageModel> defaultMessages,
    required IList<ChatModel> chats,
    required IList<TagModel> tags,
    required bool isFiltered,
  }) = _DefaultMode;

  const factory TimelineState.filterMode({
    required IList<MessageModel> messages,
    required IList<ChatModel> chats,
    required IList<MessageModel> defaultMessages,
    required IList<TagModel> tags,
    required int filterWay,
    required String searchQuery,
    required ISet<String> tagIds,
    required ISet<String> chatIds,
    required String dateFilter,
    required bool imagesOnly,
    required bool audioOnly,
    required bool strongTagFilter,
    required bool resultExist,
  }) = _FilterMode;
}
