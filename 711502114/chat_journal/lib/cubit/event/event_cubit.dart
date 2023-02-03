// ignore_for_file: omit_local_variable_types

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  bool _isFavoriteMode = false;
  bool _isSelectedMode = false;
  bool _isEditMode = false;

  late List<Event> _events;
  final List<int> selectedItemIndexes = [];

  bool get favoriteMode => _isFavoriteMode;

  bool get selectedMode => _isSelectedMode;

  bool get editMode => _isEditMode;

  List<Event> get events => _events;

  List<Event> get filterEvents =>
      _isFavoriteMode ? events.where((e) => e.isFavorite).toList() : events;

  EventCubit() : super(EventState(events: []));

  void init(Chat chat) {
    emit(state.copyWith(events: chat.events));
    _events = state.events;
  }

  void update() {
    emit(state.copyWith(events: state.events));
  }

  void changeFavorite() {
    _isFavoriteMode = !_isFavoriteMode;

    update();
  }

  void migrateEvents(Chat chat) {
    selectedItemIndexes.sort();

    final migrationEvents = <Event>[];
    for (int i in selectedItemIndexes) {
      migrationEvents.add(_events[i]);
    }

    deleteMessage();

    for (Event event in migrationEvents) {
      final unselectedEvent = event.copyWith(isSelected: false);
      chat.events.add(unselectedEvent);
    }

    update();
  }

  void startEditMode(TextEditingController fieldText) {
    _isEditMode = true;
    fieldText.text = events[selectedItemIndexes.last].message;

    update();
  }

  void copyText() {
    selectedItemIndexes.sort();
    String? text;

    for (int i in selectedItemIndexes) {
      final message = events[i].message;
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
    for (int i in selectedItemIndexes) {
      events[i] = events[i].copyWith(isFavorite: !events[i].isFavorite);
    }

    finishEditMode();
  }

  void deleteMessage() {
    selectedItemIndexes.sort();

    int shift = 0;
    for (int i in selectedItemIndexes) {
      events.removeAt(i + shift--);
    }

    finishEditMode(deleteMode: true);
  }

  void addEvent(String message, [String? path]) {
    events.add(
      Event(
        message: message,
        dateTime: DateTime.now(),
        photoPath: path,
      ),
    );

    update();
  }

  void handleSelecting(int index) {
    if (selectedItemIndexes.isEmpty) {
      _isSelectedMode = true;
      events[index] = events[index].copyWith(isSelected: true);

      selectedItemIndexes.add(index);
    } else if (!selectedItemIndexes.contains(index)) {
      events[index] = events[index].copyWith(isSelected: true);

      selectedItemIndexes.add(index);
    } else if (selectedItemIndexes.length == 1) {
      _isSelectedMode = false;
      events[index] = events[index].copyWith(isSelected: false);

      selectedItemIndexes.remove(index);
    } else {
      events[index] = events[index].copyWith(isSelected: false);

      selectedItemIndexes.remove(index);
    }

    update();
  }

  void finishEditMode({
    TextEditingController? fieldText,
    bool deleteMode = false,
    bool editSuccess = false,
  }) {
    if (!deleteMode) {
      for (int i in selectedItemIndexes) {
        events[i] = events[i].copyWith(isSelected: false);
      }
    }

    if (fieldText != null && editSuccess) {
      final index = selectedItemIndexes.last;
      events[index] = events[index].copyWith(message: fieldText.text);
    }

    fieldText?.clear();
    _isEditMode = false;

    _isSelectedMode = false;
    selectedItemIndexes.clear();

    update();
  }
}
