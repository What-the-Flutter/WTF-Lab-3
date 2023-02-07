import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/event.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  List<Event> _fullEvents = [];

  SearchCubit(List<Event> events) : super(SearchState(events)) {
    _fullEvents = state.events;
  }

  void lookForWords([String search = '']) {
    if (search.isEmpty) {
      emit(state.copyWith(_fullEvents));
      return;
    }

    final keyword = search.toLowerCase();
    final matches = _fullEvents.where((e) => _checkWords(e, keyword));
    emit(state.copyWith(matches.toList()));
  }

  bool _checkWords(Event event, String keyword) {
    return event.message.toLowerCase().contains(keyword);
  }
}
