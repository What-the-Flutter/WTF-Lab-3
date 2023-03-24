import 'package:diary_application/domain/models/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(List<Event> events) : super(SearchState(events, events));

  void lookForWords([String search = '']) {
    if (search.isEmpty) {
      emit(state.copyWith(state.fullEvents));
      return;
    }

    final keyword = search.toLowerCase();
    final matches = state.fullEvents.where((e) => _checkWords(e, keyword));
    emit(state.copyWith(matches.toList()));
  }

  bool _checkWords(Event event, String keyword) {
    return event.message.toLowerCase().contains(keyword);
  }
}
