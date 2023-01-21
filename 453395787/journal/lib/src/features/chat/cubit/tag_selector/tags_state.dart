part of 'tags_cubit.dart';

@freezed
class TagsState with _$TagsState {
  const TagsState._();

  const factory TagsState.initial({
    required TagList tags,
  }) = TagsInitialState;

  const factory TagsState.hasSelectedState({
    required TagList tags,
    required TagList selected,
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
