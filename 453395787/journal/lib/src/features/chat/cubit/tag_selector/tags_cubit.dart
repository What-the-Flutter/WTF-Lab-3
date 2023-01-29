import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/repository/tag_repository_api.dart';
import '../../../../common/models/ui/tag.dart';
import '../../../../common/utils/typedefs.dart';

part 'tags_state.dart';

part 'tags_cubit.freezed.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    required TagRepositoryApi tagRepository,
    IList<Tag>? selectedTags,
  })  : _tagRepository = tagRepository,
        super(TagsState.initial(tags: tagRepository.tags.value)) {
    if (selectedTags != null) {
      emit(
        TagsState.hasSelectedState(tags: state.tags, selected: selectedTags),
      );
    }

    _tagsStreamSubscription = _tagRepository.tags.listen((event) {
      emit(
        state.copyWith(
          tags: event,
        ),
      );
    });
  }

  final TagRepositoryApi _tagRepository;
  late final StreamSubscription<TagList> _tagsStreamSubscription;

  @override
  Future<void> close() async {
    _tagsStreamSubscription.cancel();
    super.close();
  }

  void select(Tag tag) {
    state.map(
      initial: (initial) {
        emit(
          TagsState.hasSelectedState(
            tags: initial.tags,
            selected: [tag].lock,
          ),
        );
      },
      hasSelectedState: (hasSelectedState) {
        emit(
          hasSelectedState.copyWith(
            selected: hasSelectedState.selected.add(tag),
          ),
        );
      },
    );
  }

  void unselect(Tag tag) {
    state.map(
      initial: (_) {},
      hasSelectedState: (hasSelectedState) {
        if (hasSelectedState.selected.length == 1) {
          emit(
            TagsState.initial(tags: hasSelectedState.tags),
          );
        } else {
          emit(
            hasSelectedState.copyWith(
              selected: hasSelectedState.selected.remove(tag),
            ),
          );
        }
      },
    );
  }

  void toggleSelection(Tag tag) {
    state.map(initial: (initial) {
      select(tag);
    }, hasSelectedState: (hasSelectedState) {
      if (hasSelectedState.selected.contains(tag)) {
        unselect(tag);
      } else {
        select(tag);
      }
    });
  }

  void setSelected(IList<String> tagsId) {
    final tags = state.tags
        .where(
          (e) => tagsId.contains(e.id),
        )
        .toIList();
    emit(
      TagsState.hasSelectedState(
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
