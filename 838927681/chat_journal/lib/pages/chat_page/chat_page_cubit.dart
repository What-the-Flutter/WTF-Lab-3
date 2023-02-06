import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/event.dart';
import 'chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  void loadEvents(List<Event> events) {
    emit(state.copyWith(events: events));
  }

  void deleteEvents() {
    final events = List<Event>.from(state.events);
    if (state.selectedCount == 0) {
      events.removeAt(state.selectedIndex);
    } else {
      var i = 0;
      while (i < events.length) {
        if (events[i].isSelected) {
          events.removeAt(i);
        } else {
          i++;
        }
      }
    }
    emit(state.copyWith(events: events, isSelecting: false, selectedCount: 0));
  }

  void favoritesModeToFalse() {
    emit(state.copyWith(isFavoritesMode: false));
  }

  void _changeIsFavoriteEventToOpposite(int index) {
    final events = List<Event>.from(state.events);
    final favorites = List<Event>.from(state.favorites);
    var event = state.isFavoritesMode ? favorites[index] : events[index];
    final favoritesIndex =
        state.isFavoritesMode ? index : favorites.indexOf(event);
    final allIndex = state.isFavoritesMode ? events.indexOf(event) : index;
    if (event.isFavorite == true) {
      favorites.remove(event);
      event = event.copyWith(isFavorite: false);
      events[allIndex] = event;
      emit(
        state.copyWith(
          events: events,
          favorites: favorites,
          favoritesCount: state.favoritesCount - 1,
        ),
      );
    } else {
      event = event.copyWith(isFavorite: true);
      favorites.add(event);
      events[allIndex] = event;
      emit(
        state.copyWith(
          events: events,
          favorites: favorites,
          favoritesCount: state.favoritesCount + 1,
        ),
      );
    }
  }

  void changeIsFavoriteEvent() {
    final events = List<Event>.from(
        state.isFavoritesMode ? state.favorites : state.events);
    if (state.selectedCount == 0) {
      _changeIsFavoriteEventToOpposite(state.selectedIndex);
    } else {
      for (var i = 0; i < state.events.length; i++) {
        if (events[i].isSelected) {
          _changeIsFavoriteEventToOpposite(i);
        }
      }
    }
    final favorites = List<Event>.from(state.favorites);
    favorites.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    emit(
      state.copyWith(favorites: favorites),
    );
  }

  void addEvent(Event event) {
    final events = List<Event>.from(state.events);
    events.add(event);
    emit(
      state.copyWith(events: events),
    );
  }

  void changeFavoritesMode() {
    final value = !state.isFavoritesMode;
    emit(state.copyWith(isFavoritesMode: value));
  }

  void selectionToFalse() {
    for (var i = 0; i < state.events.length; i++) {
      if (state.events[i].isSelected) {
        state.events[i] = state.events[i].copyWith(isSelected: false);
      }
    }
    emit(
      state.copyWith(
          events: state.events, selectedCount: 0, isSelecting: false),
    );
  }

  void changeSelection() {
    if (state.isSelecting) {
      for (var i = 0; i < state.events.length; i++) {
        if (state.events[i].isSelected) {
          state.events[i] = state.events[i].copyWith(isSelected: false);
        }
      }
      emit(state.copyWith(
          events: state.events,
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

  void editingToValue(bool value) {
    emit(state.copyWith(isEditing: value));
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
        favoritesCount: state.favoritesCount - 1,
        favorites: favorites,
      ),
    );
  }

  void incrementFavoritesCount(Event event) {
    final favorites = List<Event>.from(state.favorites);
    favorites.add(event);
    emit(
      state.copyWith(
        favoritesCount: state.favoritesCount + 1,
        favorites: favorites,
      ),
    );
  }

  void incrementSelectedCount() {
    emit(state.copyWith(selectedCount: state.selectedCount + 1));
  }

  void changeSelectedIndex(int index) {
    emit(state.copyWith(events: state.events, selectedIndex: index));
  }

  void changeIsEditingToValue(bool value) {
    emit(state.copyWith(isEditing: value));
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
    emit(state.copyWith(selectedIcon: index));
  }

  void changeText(String text) {
    state.events[state.selectedIndex] =
        state.events[state.selectedIndex].copyWith(
      text: text,
    );
    emit(state.copyWith(events: state.events));
  }

  void changeRadioIndex(int? value) {
    if (value != null) {
      emit(state.copyWith(selectedRadioIndex: value));
    } else {
      emit(state.copyWith(selectedRadioIndex: null));
    }
  }
}
