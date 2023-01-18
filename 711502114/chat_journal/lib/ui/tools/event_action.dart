// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/chat.dart';
import '../../models/event.dart';

class EventAction {
  final Chat chat;
  final TextEditingController fieldText;
  final List<int> selectedItemIndexes = [];

  late List<Event> _events;

  List<Event> get events => _events;

  bool _isFavorite = false;

  bool get favorite => _isFavorite;

  bool _isSelectedMode = false;

  bool get selectedMode => _isSelectedMode;

  bool _isEditMode = false;

  bool get editMode => _isEditMode;

  EventAction(
    this.chat,
    this.fieldText,
  ) {
    _events = chat.events;
  }

  void lookForWords() {}

  void showFavorites() {
    _isFavorite = !_isFavorite;
    if (_isFavorite) {
      _events = chat.events.where((element) => element.isFavorite).toList();
    } else {
      _events = chat.events;
    }
  }

  void disableSelect() {
    for (int i in selectedItemIndexes) {
      events[i] = events[i].copyWith(isSelected: false);
    }

    fieldText.clear();
    _isEditMode = false;

    finishEditMode();
  }

  void turnOnEditMode() {
    _isEditMode = true;
    fieldText.text = events[selectedItemIndexes.last].message;
  }

  void turnOffEditMode() {
    _isEditMode = false;
    events[selectedItemIndexes.last] =
        events[selectedItemIndexes.last].copyWith(message: fieldText.text);
    disableSelect();
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

    disableSelect();
  }

  void changeFavoriteStatus() {
    for (int i in selectedItemIndexes) {
      events[i] = events[i].copyWith(isFavorite: !events[i].isFavorite);
    }

    disableSelect();
  }

  void deleteMessage() {
    selectedItemIndexes.sort();

    int shift = 0;
    for (int i in selectedItemIndexes) {
      events.removeAt(i + shift--);
    }

    finishEditMode();
  }

  void finishEditMode() {
    _isSelectedMode = false;
    selectedItemIndexes.clear();
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
  }
}
