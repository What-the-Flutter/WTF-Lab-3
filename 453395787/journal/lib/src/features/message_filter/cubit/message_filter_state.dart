part of 'message_filter_cubit.dart';

@freezed
class MessageFilterState with _$MessageFilterState {
  const MessageFilterState._();

  const factory MessageFilterState({
    required IList<Tag> tags,
    required IList<TextTag> textTags,
    required IList<Chat> chats,
    @Default(IListConst([])) IList<Tag> selectedTags,
    @Default(IListConst([])) IList<TextTag> selectedTextTags,
    @Default(IListConst([]))  IList<Chat> selectedChats,
  }) = _MessageFilterState;

  int get amountOfSelected =>
      selectedTags.length + selectedTextTags.length + selectedChats.length;
}
