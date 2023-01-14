import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../common/api/message_provider_api.dart';
import '../../../../common/models/tag.dart';
import 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    required MessageProviderApi messageProviderApi,
  })  : _repository = messageProviderApi,
        super(TagsState.initial(tags: messageProviderApi.tags.value));

  final MessageProviderApi _repository;

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
