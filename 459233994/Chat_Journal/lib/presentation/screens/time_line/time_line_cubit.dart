import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/event_repository.dart';
import '../../../domain/entities/event.dart';
import 'time_line_state.dart';

class TimeLineCubit extends Cubit<TimeLineState> {
  final EventRepositoryImpl _eventRepository;

  TimeLineCubit({required eventRepository})
      : _eventRepository = eventRepository,
        super(TimeLineState(isLoaded: false));

  Future<void> loadEvents() async {
    final events = await _eventRepository.getEventsForTimeLine();
    emit(
      state.copyWith(
        events: events,
        isFavorite: false,
        isSearched: false,
        isLoaded: true,
      ),
    );
  }

  List<Event> getEvents() {
    return state.events!;
  }

  void removeEventsFromExcludedChats(List<String> excludedChats) {
    for (var index = 0; index < excludedChats.length; index++) {
          state.events
          ?.removeWhere((element) => element.chatId == excludedChats[index]);
    }
    emit(state.copyWith(events: state.events));
  }

  void removeEventsWithoutTags(List<String> pickedTags){
    final events = state.events?.where((event) {
      if (event.tags == null) {
        return false;
      }

      for (var tag in event.tags!) {
        if (pickedTags.contains(tag)) {
          return true;
        }
      }

      return false;
    }).toList();
    emit(state.copyWith(events: events));
  }

  void changeFavoriteState() {
    state.isFavorite == true
        ? emit(state.copyWith(isFavorite: false))
        : emit(state.copyWith(isFavorite: true));
  }

  void changeSearchedState() {
    state.isSearched == true
        ? emit(state.copyWith(isSearched: false))
        : emit(state.copyWith(isSearched: true));
    print(state.isSearched);
  }
}
