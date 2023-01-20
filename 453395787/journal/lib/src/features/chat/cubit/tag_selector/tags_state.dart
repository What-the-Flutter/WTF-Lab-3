part of 'tags_cubit.dart';

@freezed
class TagsState with _$TagsState {
  const TagsState._();

  const factory TagsState.initial({
    required IList<Tag> tags,
  }) = TagsInitialState;

  const factory TagsState.hasSelectedState({
    required IList<Tag> tags,
    required IList<Tag> selected,
  }) = TagsHasSelectedState;

  bool isSelected(Tag tag) {
    return map(
      initial: (initial) => false,
      hasSelectedState: (hasSelectedState) =>
          hasSelectedState.selected.contains(tag),
    );
  }

  bool get hasSelected => this is TagsHasSelectedState;
}
