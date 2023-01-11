import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/tag.dart';

part 'tags_state.freezed.dart';

@freezed
class TagsState with _$TagsState {
  const TagsState._();

  const factory TagsState.initial({
    required IList<Tag> tags,
  }) = TagsInitialState;

  const factory TagsState.hasSelected({
    required IList<Tag> tags,
    required IList<Tag> selected,
  }) = TagsHasSelectedState;

  bool isSelected(Tag tag) {
    return map(
      initial: (initial) => false,
      hasSelected: (hasSelected) => hasSelected.selected.contains(tag),
    );
  }

  bool get hasSelected => this is TagsHasSelectedState;
}
