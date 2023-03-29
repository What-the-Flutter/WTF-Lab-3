import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/event.dart';

part 'searching_page_state.dart';

class SearchingPageCubit extends Cubit<SearchingPageState> {
  SearchingPageCubit() : super(const SearchingPageState());

  void init(Set<String> tags, List<Event> events) {
    emit(
      state.copyWith(
        newTagsSelected: List.generate(
          tags.length,
          (index) => false,
        ),
        newTags: tags,
        newEvents: events,
      ),
    );
  }

  void updateInput(String value) {
    if (value != '') {
      startLoading();
    }
    emit(
      state.copyWith(
        newInput: value,
      ),
    );
  }

  void toggleTag(int index) {
    final tags = state.selectedTags;
    tags[index] = !state.selectedTags[index];
    startLoading();
    emit(
      state.copyWith(
        newTagsSelected: tags,
      ),
    );
  }

  void clearFoundedEvents() {
    emit(
      state.copyWith(
        newInput: '',
      ),
    );
  }

  void startLoading() {
    emit(
      state.copyWith(
        loaded: true,
      ),
    );
    Future.delayed(
      const Duration(
        milliseconds: 3000,
      ),
    ).then(
      (_) => emit(
        state.copyWith(
          loaded: false,
        ),
      ),
    );
  }
}
