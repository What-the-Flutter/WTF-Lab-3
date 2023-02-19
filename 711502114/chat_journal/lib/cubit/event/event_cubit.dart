// ignore_for_file: omit_local_variable_types

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/category.dart';
import '../../models/chat.dart';
import '../../models/event.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventState(events: [], selectedItemIndexes: []));

  bool get favoriteMode => state.isFavoriteMode;

  bool get selectedMode => state.isSelectedMode;

  bool get editMode => state.isEditMode;

  bool get categoryMode => state.isCategoryMode;

  Category? get category => state.category;

  List<Event> get events => state.events;

  List<Event> get filterEvents => state.isFavoriteMode
      ? events.where((e) => e.isFavorite).toList()
      : events;

  void init(Chat chat) {
    emit(state.copyWith(events: chat.events));
  }

  void changeFavorite() {
    state.isFavoriteMode = !state.isFavoriteMode;

    emit(state.copyWith(events: state.events));
  }

  void migrateEvents(Chat chat) {
    state.selectedItemIndexes.sort();

    final migrationEvents = <Event>[];
    for (int i in state.selectedItemIndexes) {
      migrationEvents.add(state.events[i]);
    }

    deleteMessage();

    for (Event event in migrationEvents) {
      final unselectedEvent = event.copyWith(isSelected: false);
      chat.events.add(unselectedEvent);
    }

    emit(state.copyWith(events: state.events));
  }

  void startEditMode(TextEditingController fieldText) {
    state.isEditMode = true;
    fieldText.text = state.events[state.selectedItemIndexes.last].message;

    emit(state.copyWith(events: state.events));
  }

  void copyText() {
    state.selectedItemIndexes.sort();
    String? text;

    for (int i in state.selectedItemIndexes) {
      final message = state.events[i].message;
      if (text == null) {
        text = '$message\n';
      } else {
        text += '\n$message\n';
      }
    }

    Clipboard.setData(ClipboardData(text: text));

    finishEditMode();
  }

  void changeFavoriteStatus() {
    for (int i in state.selectedItemIndexes) {
      state.events[i] = state.events[i].copyWith(
        isFavorite: !state.events[i].isFavorite,
      );
    }

    finishEditMode();
  }

  void deleteMessage() {
    state.selectedItemIndexes.sort();

    int shift = 0;
    for (int i in state.selectedItemIndexes) {
      state.events.removeAt(i + shift--);
    }

    finishEditMode(deleteMode: true);
  }

  void addEvent(String message, [String? path]) {
    state.events.add(
      Event(
        message: message,
        creationTime: DateTime.now().toString(),
        photoPath: path,
        category: state.category,
      ),
    );

    state.category = null;

    emit(state.copyWith(events: state.events));
  }

  void handleSelecting(int index) {
    if (state.selectedItemIndexes.isEmpty) {
      state.isSelectedMode = true;
      state.events[index] = state.events[index].copyWith(isSelected: true);

      state.selectedItemIndexes.add(index);
    } else if (!state.selectedItemIndexes.contains(index)) {
      state.events[index] = state.events[index].copyWith(isSelected: true);

      state.selectedItemIndexes.add(index);
    } else if (state.selectedItemIndexes.length == 1) {
      state.isSelectedMode = false;
      state.events[index] = state.events[index].copyWith(isSelected: false);

      state.selectedItemIndexes.remove(index);
    } else {
      state.events[index] = state.events[index].copyWith(isSelected: false);

      state.selectedItemIndexes.remove(index);
    }

    emit(state.copyWith(events: state.events));
  }

  void finishEditMode({
    TextEditingController? fieldText,
    bool deleteMode = false,
    bool editSuccess = false,
  }) {
    if (!deleteMode) {
      for (int i in state.selectedItemIndexes) {
        state.events[i] = state.events[i].copyWith(
          isSelected: false,
          category: state.category,
        );
      }
    }

    if (fieldText != null && editSuccess) {
      final index = state.selectedItemIndexes.last;
      state.events[index] = state.events[index].copyWith(
        message: fieldText.text,
      );
    }

    state.isEditMode = false;
    state.isSelectedMode = false;

    state.category = null;

    state.selectedItemIndexes.clear();
    fieldText?.clear();

    emit(state.copyWith(events: state.events));
  }

  void openCategory() {
    state.isCategoryMode = true;

    emit(state.copyWith(events: state.events));
  }

  void closeCategory() {
    state.isCategoryMode = false;

    emit(state.copyWith(events: state.events));
  }

  void setCategory(Category? category) {
    state.category = category;

    closeCategory();
  }
}
