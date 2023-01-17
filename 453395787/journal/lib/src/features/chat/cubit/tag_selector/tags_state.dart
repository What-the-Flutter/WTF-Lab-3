import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/tag.dart';
import '../../../../common/utils/typedefs.dart';

part 'tags_state.freezed.dart';

@freezed
class TagsState with _$TagsState {
  const TagsState._();

  const factory TagsState.initial({
    required TagList tags,
  }) = TagsInitialState;

  const factory TagsState.hasSelected({
    required TagList tags,
    required TagList selected,
  }) = TagsHasSelectedState;

  bool isSelected(Tag tag) {
    return map(
      initial: (initial) => false,
      hasSelected: (hasSelected) => hasSelected.selected.contains(tag),
    );
  }

  bool get hasSelected => this is TagsHasSelectedState;
}
