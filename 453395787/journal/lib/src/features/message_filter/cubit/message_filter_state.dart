part of 'message_filter_cubit.dart';

@freezed
class MessageFilterState with _$MessageFilterState {
  const MessageFilterState._();

  const factory MessageFilterState({
    required IList<Tag> tags,
    required IList<TextTag> textTags,
    required IList<Chat> chats,
    required IList<Tag> selectedTags,
    required IList<TextTag> selectedTextTags,
    required IList<Chat> selectedChats,
  }) = _MessageFilterState;

  int get amountOfSelected =>
      selectedTags.length + selectedTextTags.length + selectedChats.length;
}
