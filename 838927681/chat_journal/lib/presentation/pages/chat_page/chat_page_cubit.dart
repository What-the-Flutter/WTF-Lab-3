import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import 'chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ApiEventRepository eventRepository;
  final ApiChatRepository chatRepository;

  ChatCubit({
    required this.eventRepository,
    required this.chatRepository,
  }) : super(ChatState());

  Future<void> initState(int id) async {
    final events = await eventRepository.getEvents(id);
    emit(state.copyWith(events: events));
  }

  void favoritesModeToFalse() {
    emit(state.copyWith(isFavoritesMode: false));
  }

  void _changeIsFavoriteEventToOpposite(
      int index, List<Event> events, List<Event> favorites) {
    var event = state.isFavoritesMode ? favorites[index] : events[index];
    final allIndex = state.isFavoritesMode ? events.indexOf(event) : index;
    if (event.isFavorite == true) {
      favorites.remove(event);
      event = event.copyWith(isFavorite: false);
      eventRepository.updateEvent(event);
      events[allIndex] = event;
    } else {
      event = event.copyWith(isFavorite: true);
      favorites.add(event);
      eventRepository.updateEvent(event);
      events[allIndex] = event;
    }
  }

  void changeIsFavoriteEvent() {
    final events = List<Event>.from(
        state.isFavoritesMode ? state.favorites : state.events);
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    if (state.selectedCount == 1) {
      _changeIsFavoriteEventToOpposite(
          state.selectedIndex, allEvents, favorites);
    } else {
      for (var i = 0; i < state.events.length; i++) {
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
        events: allEvents,
        selectedCount: 0,
        isSelecting: false,
        favorites: favorites,
      ),
    );
  }

  void addEvent(Event event) async {
    final events = List<Event>.from(state.events);
    events.add(event);
    await eventRepository.addEvent(event);
    emit(
      state.copyWith(
        events: events,
        isFavoritesMode: false,
        selectedIcon: 0,
        isSendingImage: false,
      ),
    );
  }

  void changeFavoritesMode() {
    final value = !state.isFavoritesMode;
    emit(
      state.copyWith(
        isFavoritesMode: value,
        isSendingImage: false,
      ),
    );
  }

  void _selectionToFalse(List<Event> events) {
    for (var i = 0; i < events.length; i++) {
      if (events[i].isSelected) {
        events[i] = events[i].copyWith(isSelected: false);
      }
    }
  }

  void selectionToFalse() {
    final events = List<Event>.from(state.events);
    _selectionToFalse(events);
    emit(
      state.copyWith(
        events: events,
        selectedCount: 0,
        isSelecting: false,
        selectedRadioIndex: 0,
      ),
    );
  }

  void changeSelection() {
    if (state.isSelecting) {
      final events = List<Event>.from(state.events);
      _selectionToFalse(events);
      emit(state.copyWith(
          events: events,
          isSelecting: false,
          selectedCount: 0,
          isSelectedImage: false));
    } else {
      var event = state.events[state.selectedIndex];
      event = event.copyWith(isSelected: true);
      state.events[state.selectedIndex] = event;
      final isSelectedImageState =
          state.events[state.selectedIndex].imagePath == '' ? false : true;
      emit(
        state.copyWith(
          events: state.events,
          isSelecting: true,
          selectedCount: 1,
          isSelectedImage: isSelectedImageState,
        ),
      );
    }
  }

  void decrementSelectedCount() {
    final selectingState = state.selectedCount == 1 ? false : true;
    final isSelectedImageState =
        !selectingState ? false : state.isSelectedImage;
    emit(
      state.copyWith(
        selectedCount: state.selectedCount - 1,
        isSelecting: selectingState,
        isSelectedImage: isSelectedImageState,
      ),
    );
  }

  void decrementFavoritesCount(Event event) {
    final favorites = List<Event>.from(state.favorites);
    favorites.remove(event);
    emit(
      state.copyWith(
        favorites: favorites,
      ),
    );
  }

  void incrementFavoritesCount(Event event) {
    final favorites = List<Event>.from(state.favorites);
    favorites.add(event);
    emit(
      state.copyWith(
        favorites: favorites,
      ),
    );
  }

  void incrementSelectedCount() {
    emit(state.copyWith(selectedCount: state.selectedCount + 1));
  }

  void changeSelectedIndex(int index) {
    final events = List<Event>.from(state.events);
    var isSelectedImageState = state.isSelectedImage;
    if (!state.isSelecting) {
      var event = events[index];
      event = event.copyWith(isSelected: true);
      events[index] = event;
    }
    emit(
      state.copyWith(
        events: events,
        selectedIndex: index,
        isSelecting: true,
        selectedCount: 1,
        isSelectedImage: isSelectedImageState,
      ),
    );
  }

  void changeIsEditingToValue(bool value) {
    final events = List<Event>.from(state.events);
    _selectionToFalse(events);
    emit(
      state.copyWith(
        events: events,
        isEditing: value,
        isSelecting: false,
        selectedCount: 0,
      ),
    );
  }

  void changeIsTypingToValue(bool value) {
    emit(state.copyWith(isTyping: value));
  }

  void changeIsSendingImageToValue(bool value) {
    emit(state.copyWith(isSendingImage: value));
  }

  void changeSelectedItem(int index) {
    final selectedState = state.events[index].isSelected;
    final bool isSelectedImageState;
    if (selectedState == true) {
      isSelectedImageState =
          state.events[index].imagePath != '' ? false : state.isSelectedImage;
      decrementSelectedCount();
    } else {
      isSelectedImageState =
          state.events[index].imagePath != '' ? true : state.isSelectedImage;
      incrementSelectedCount();
    }

    state.events[index] =
        state.events[index].copyWith(isSelected: !selectedState);
    emit(
      state.copyWith(
          events: state.events, isSelectedImage: isSelectedImageState),
    );
  }

  void changeIsSelectedImage() {
    emit(state.copyWith(isSelectedImage: !state.isSelectedImage));
  }

  void changeIsSelectingCategory(bool value) {
    final isSendingImage = value ? false : state.isSelectedImage;
    emit(
      state.copyWith(
        isSelectingCategory: value,
        isSendingImage: isSendingImage,
      ),
    );
  }

  void changeSelectedIcon(int index) {
    emit(
      state.copyWith(
        selectedIcon: index,
        isSelectingCategory: false,
      ),
    );
  }

  void changeText(String text) {
    final events = List<Event>.from(state.events);
    events[state.selectedIndex] = events[state.selectedIndex].copyWith(
      text: text,
    );
    eventRepository.updateEvent(events[state.selectedIndex]);
    emit(state.copyWith(events: events, isEditing: false));
  }

  void changeRadioIndex(int? value) {
    if (value != null) {
      emit(state.copyWith(selectedRadioIndex: value));
    } else {
      emit(state.copyWith(selectedRadioIndex: 0));
    }
  }

  void _deleteEvents(List<Event> allEvents, List<Event> favorites, int index) {
    final event = state.isFavoritesMode ? favorites[index] : allEvents[index];
    if (event.isFavorite) {
      favorites.remove(event);
    }
    if (state.selectedCount == 1) {
      allEvents.remove(event);
      eventRepository.deleteEvent(event);
    } else {
      var i = 0;
      while (i < allEvents.length) {
        if (allEvents[i].isSelected) {
          allEvents.removeAt(i);
          eventRepository.deleteEvent(allEvents[i]);
        } else {
          i++;
        }
      }
    }
  }

  void deleteEvents(int index) {
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    _deleteEvents(allEvents, favorites, index);
    _selectionToFalse(allEvents);
    emit(
      state.copyWith(
        events: allEvents,
        favorites: favorites,
        isSelecting: false,
        selectedCount: 0,
      ),
    );
  }

  void onTapEvent(int index) {
    final events = List<Event>.from(
        state.isFavoritesMode ? state.favorites : state.events);
    final favorites = List<Event>.from(state.favorites);
    final allEvents = List<Event>.from(state.events);
    var selectedCount = state.selectedCount;
    if (!state.isSelecting) {
      if (state.selectedCount == 0) {
        _changeIsFavoriteEventToOpposite(index, allEvents, favorites);
      } else {
        for (var i = 0; i < state.events.length; i++) {
          if (events[i].isSelected) {
            _changeIsFavoriteEventToOpposite(i, allEvents, favorites);
          }
        }
      }
      favorites.sort((a, b) {
        return a.dateTime.compareTo(b.dateTime);
      });
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

  void onDismissed(
      {required int index,
      required bool startToEnd,
      required bool endToStart}) {
    final events = List<Event>.from(state.events);
    final favorites = List<Event>.from(state.favorites);
    var isEditing = state.isEditing;
    var selectedIndex = state.selectedIndex;
    if (startToEnd) {
      if (state.events[index].imagePath != '') {
        isEditing = true;
      }
      _selectionToFalse(events);
    } else if (endToStart) {
      selectedIndex = index;
      _deleteEvents(events, favorites, index);
    }
    emit(
      state.copyWith(
        events: events,
        selectedIndex: selectedIndex,
        isSelecting: false,
        selectedCount: 0,
        isEditing: isEditing,
      ),
    );
  }

  void transferEvents(int id) {
    final favorites = List<Event>.from(state.favorites);
    final events = List<Event>.from(state.events);
    if (state.selectedCount == 1) {
      final event = events[state.selectedIndex];
      events.remove(event);
      eventRepository.updateEvent(
        event.copyWith(parentId: id, isSelected: false),
      );
    } else {
      var i = 0;
      while (i < events.length) {
        if (events[i].isSelected) {
          eventRepository.updateEvent(
            events[i].copyWith(
              parentId: id,
              isSelected: false,
            ),
          );
          events.removeAt(i);
        }
      }
    }
    emit(
      state.copyWith(
        events: events,
        favorites: favorites,
        isSelecting: false,
        selectedCount: 0,
        selectedRadioIndex: 0,
      ),
    );
  }

  Future<List<Chat>> getChats() async {
    return await chatRepository.getChats();
  }
}
