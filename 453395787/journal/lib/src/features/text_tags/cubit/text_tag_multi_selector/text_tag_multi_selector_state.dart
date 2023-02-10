part of 'text_tag_multi_selector_cubit.dart';

@freezed
class TextTagMultiSelectorState with _$TextTagMultiSelectorState {
  const TextTagMultiSelectorState._();

  const factory TextTagMultiSelectorState({
    required IList<TextTag> tags,
    required IList<String> selectedIds,
  }) = _TextTagMutliSelectorState;
  
  bool isSelected(TextTag tag) => selectedIds.contains(tag.id);
}
