import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/event.dart';
import 'chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  void loadEvents(List<Event> events) {
    emit(state.copyWith(events: events));
  }

  void deleteEvents() {
    final events = state.events;
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
    var event = state.events[index];
    if (event.isFavorite == true) {
      event = event.copyWith(isFavorite: false);
      state.events[index] = event;
      emit(state.copyWith(
          events: state.events, favoritesCount: state.favoritesCount - 1));
    } else {
      event = event.copyWith(isFavorite: true);
      state.events[index] = event;
      emit(state.copyWith(
          events: state.events, favoritesCount: state.favoritesCount + 1));
    }
  }

  void changeIsFavoriteEvent() {
    if (state.selectedCount == 0) {
      _changeIsFavoriteEventToOpposite(state.selectedIndex);
    } else {
      for (var i = 0; i < state.events.length; i++) {
        if (state.events[i].isSelected) {
          _changeIsFavoriteEventToOpposite(i);
        }
      }
    }
  }

  void addEvent(Event event) {
    final events = state.events;
    events.add(event);
    emit(state.copyWith(events: events));
    //emit(state.copyWith(events: events));
  }

  void changeFavoritesMode() {
    emit(state.copyWith(isFavoritesMode: !state.isFavoritesMode));
  }

  void selectionToFalse() {
    for (var i = 0; i < state.events.length; i++) {
      if (state.events[i].isSelected) {
        state.events[i] = state.events[i].copyWith(isSelected: false);
      }
    }
    emit(state.copyWith(
        events: state.events, selectedCount: 0, isSelecting: false));
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
      emit(state.copyWith(
        events: state.events,
        isSelecting: true,
        selectedCount: 1,
        isSelectedImage: isSelectedImageState,
      ));
    }
  }

  void editingToValue(bool value) {
    emit(state.copyWith(isEditing: value));
  }

  void decrementFavoritesCount() {
    emit(state.copyWith(favoritesCount: state.favoritesCount - 1));
  }

  void incrementFavoritesCount() {
    emit(state.copyWith(favoritesCount: state.favoritesCount + 1));
  }

  void decrementSelectedCount() {
    final selectingState = state.selectedCount == 1 ? false : true;
    final isSelectedImageState =
        !selectingState ? false : state.isSelectedImage;
    emit(state.copyWith(
      selectedCount: state.selectedCount - 1,
      isSelecting: selectingState,
      isSelectedImage: isSelectedImageState,
    ));
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
    emit(state.copyWith(
        events: state.events, isSelectedImage: isSelectedImageState));
  }

  void changeIsSelectedImage() {
    emit(state.copyWith(isSelectedImage: !state.isSelectedImage));
  }
}
