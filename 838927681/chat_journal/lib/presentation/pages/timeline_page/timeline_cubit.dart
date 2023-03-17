import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtager/functions.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import '../../../domain/repositories/api_tag_repository.dart';
import 'timeline_state.dart';

class TimelineCubit extends Cubit<TimelineState> {
  final ApiEventRepository _eventRepository;
  final ApiChatRepository _chatRepository;
  final ApiTagRepository _tagRepository;
  late final StreamSubscription<List<Event>> _eventStream;

  TimelineCubit({
    required ApiEventRepository eventRepository,
    required ApiChatRepository chatRepository,
    required ApiTagRepository tagRepository,
  })  : _eventRepository = eventRepository,
        _chatRepository = chatRepository,
        _tagRepository = tagRepository,
        super(const TimelineState(
          events: [],
          isEditingState: false,
          isSelectingState: false,
          favorites: [],
          isFavoritesMode: false,
          selectedIndex: 0,
          selectedCount: 0,
          tags: [],
          selectedRadioIndex: 0,
        )) {
    _init();
    List<Event> _getFavorites(List<Event> events) {
      return events.where((element) => element.isFavorite).toList();
    }
  }

  void _init() async {
    final events = await _eventRepository.getAllEvents();
    events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final favorites = events.where((element) => element.isFavorite).toList();
    emit(state.copyWith(events: events, favorites: favorites));
    _eventStream = _eventRepository.eventStream.listen((event) {
      final events = event.toList();
      events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      final favorites = events.where((element) => element.isFavorite).toList();
      emit(state.copyWith(events: events, favorites: favorites));
    });
  }

  void changeIsSelectingState(bool value) =>
      emit(state.copyWith(isSelectingState: value));

  void changeIsEditingState({required bool value, int? index}) {
    final newIndex = index ?? state.selectedIndex;
    emit(state.copyWith(isEditingState: value, selectedIndex: newIndex));
  }

  void changeIsFavoritesMode() {
    final value = !state.isFavoritesMode;
    emit(
      state.copyWith(
        isFavoritesMode: value,
      ),
    );
  }

  void changeSelectedIndex(int index) =>
      emit(state.copyWith(selectedIndex: index));

  void _deleteEvents(List<Event> allEvents, List<Event> favorites, int index) {
    final event = state.isFavoritesMode ? favorites[index] : allEvents[index];
    if (state.selectedCount <= 1) {
      allEvents.remove(event);
      _eventRepository.deleteEvent(event);
      for (final tagText in extractHashTags(event.text)) {
        _tagRepository.removeTag(
            state.tags.firstWhere((element) => element.text == tagText));
      }
    } else {
      var i = 0;
      while (i < allEvents.length) {
        if (allEvents[i].isSelected) {
          _eventRepository.deleteEvent(allEvents[i]);
          for (final tagText in extractHashTags(event.text)) {
            _tagRepository.removeTag(
                state.tags.firstWhere((element) => element.text == tagText));
          }
        }
        allEvents.removeWhere((element) => element.isSelected);
        i++;
      }
    }
  }

  void _selectionToFalse(List<Event> events) {
    for (var i = 0; i < events.length; i++) {
      if (events[i].isSelected) {
        events[i] = events[i].copyWith(isSelected: false);
      }
    }
  }

  void deleteEvents(int index) {
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    final chatId = allEvents.first.parentId;
    _deleteEvents(allEvents, favorites, index);
    _selectionToFalse(allEvents);
    if (allEvents.isNotEmpty) {
      final event = allEvents.last;
      _chatRepository.updateLast(
          event.parentId, event.text, event.dateTime, false);
    } else {
      _chatRepository.updateLast(
          chatId, 'No events. Click to create one', null, false);
    }
    emit(
      state.copyWith(
        isSelectingState: false,
        selectedCount: 0,
      ),
    );
  }

  void _changeIsFavoriteEventToOpposite(
    int index,
    List<Event> events,
    List<Event> favorites,
  ) {
    var event = state.isFavoritesMode ? favorites[index] : events[index];
    final allIndex = state.isFavoritesMode ? events.indexOf(event) : index;
    if (event.isFavorite == true) {
      favorites.remove(event);
      event = event.copyWith(isFavorite: false);
      _eventRepository.updateEvent(event);
      events[allIndex] = event;
    } else {
      event = event.copyWith(isFavorite: true);
      favorites.add(event);
      _eventRepository.updateEvent(event);
      events[allIndex] = event;
    }
  }

  void onTapEvent(int index) {
    final events = List<Event>.from(
      state.isFavoritesMode ? state.favorites : state.events,
    );
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    var selectedCount = state.selectedCount;
    if (!state.isSelectingState) {
      if (state.selectedCount <= 1) {
        _changeIsFavoriteEventToOpposite(index, allEvents, favorites);
      } else {
        for (var i = 0; i < state.events.length; i++) {
          if (events[i].isSelected) {
            _changeIsFavoriteEventToOpposite(i, allEvents, favorites);
          }
        }
      }
      favorites.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else {
      final event =
          allEvents[index].copyWith(isSelected: !allEvents[index].isSelected);
      allEvents[index] = event;
      selectedCount = event.isSelected ? selectedCount + 1 : selectedCount - 1;
    }
    emit(
      state.copyWith(
        selectedIndex: index,
        events: allEvents,
        favorites: favorites,
        selectedCount: selectedCount,
      ),
    );
  }

  void changeIsFavoriteEvent() {
    final events = List<Event>.from(
        state.isFavoritesMode ? state.favorites : state.events);
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    if (state.selectedCount == 1) {
      _changeIsFavoriteEventToOpposite(
        state.selectedIndex,
        allEvents,
        favorites,
      );
    } else {
      for (var i = 0; i < allEvents.length; i++) {
        if (events[i].isSelected) {
          _changeIsFavoriteEventToOpposite(i, allEvents, favorites);
        }
      }
    }
    favorites.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    _selectionToFalse(allEvents);
    emit(
      state.copyWith(
        selectedCount: 0,
        isSelectingState: false,
      ),
    );
  }

  Future<List<Chat>> getChats() async {
    return await _chatRepository.getChats();
  }

  void selectionToFalse() {
    final events = List<Event>.from(state.events);
    _selectionToFalse(events);
    emit(
      state.copyWith(
        events: events,
        selectedCount: 0,
        isSelectingState: false,
        selectedRadioIndex: 0,
      ),
    );
  }

  void changeRadioIndex(int? value) =>
      emit(state.copyWith(selectedRadioIndex: value ?? 0));

  void changeEvents(List<Event> events) => emit(state.copyWith(events: events));

  @override
  Future<void> close() {
    _eventStream.cancel();
    return super.close();
  }
}
