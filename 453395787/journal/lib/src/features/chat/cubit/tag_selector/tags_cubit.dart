import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/tag_provider_api.dart';
import '../../../../common/models/tag.dart';
import '../../../../common/utils/typedefs.dart';

part 'tags_state.dart';

part 'tags_cubit.freezed.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    required TagProviderApi tagProviderApi,
  })  : _provider = tagProviderApi,
        super(TagsState.initial(tags: tagProviderApi.tags.value)) {
    _tagsStreamSubscription = _provider.tags.listen((event) {
      emit(
        state.copyWith(
          tags: event,
        ),
      );
    });
  }

  final TagProviderApi _provider;
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

  void setSelected(IList<Id> tagsId) {
    final tags = state.tags.where((e) => tagsId.contains(e.id)).toIList();
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
