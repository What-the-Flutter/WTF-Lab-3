import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../common/models/tag.dart';
import '../../data/tags.dart';
import 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    TagsState? state,
  }) : super(state ?? TagsState.initial(tags: Tags.list));

  void select(Tag tag) {
    state.map(
      initial: (initial) {
        emit(
          TagsState.hasSelected(
            tags: initial.tags,
            selected: IList({tag}),
          ),
        );
      },
      hasSelected: (hasSelected) {
        emit(
          hasSelected.copyWith(
            selected: hasSelected.selected.add(tag),
          ),
        );
      },
    );
  }

  void unselect(Tag tag) {
    state.map(
      initial: (_) {},
      hasSelected: (hasSelected) {
        if (hasSelected.selected.length == 1) {
          emit(
            TagsState.initial(tags: hasSelected.tags),
          );
        } else {
          emit(
            hasSelected.copyWith(
              selected: hasSelected.selected.remove(tag),
            ),
          );
        }
      },
    );
  }

  void toggleSelection(Tag tag) {
    state.map(initial: (initial) {
      select(tag);
    }, hasSelected: (hasSelected) {
      if (hasSelected.selected.contains(tag)) {
        unselect(tag);
      } else {
        select(tag);
      }
    });
  }

  void setSelected(IList<Tag> tags) {
    emit(
      TagsState.hasSelected(
        tags: state.tags,
        selected: tags,
      ),
    );
  }

  void reset() {
    emit(
      TagsState.initial(
        tags: state.tags,
      ),
    );
  }
}
