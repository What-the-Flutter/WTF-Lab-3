import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../common/api/message_provider_api.dart';
import '../../../../common/models/tag.dart';
import '../../../../common/utils/typedefs.dart';
import 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    required MessageProviderApi messageProviderApi,
  })  : _repository = messageProviderApi,
        super(TagsState.initial(tags: messageProviderApi.tags.value)) {
    _subscription = _repository.tags.listen((event) {
      emit(
        state.copyWith(
          tags: event,
        ),
      );
    });
  }

  final MessageProviderApi _repository;
  late final StreamSubscription<TagList> _subscription;

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }

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

  void setSelected(TagList tags) {
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
