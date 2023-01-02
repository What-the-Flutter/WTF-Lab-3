import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';

// EventState
class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventState(listEvent: []));

  void initializer(List<Event> event) {
    emit(state.copyWith(listEvent: event));
  }

  void addEvent({
    required String content,
    required String type,
  }) {
    final event = Event(
      messageContent: content,
      messageType: type,
      messageTime: DateTime.now(),
      isFavorit: false,
      isSelected: false,
    );
    final newListEvent = state.listEvent;
    newListEvent.insert(
      0,
      event,
    );
    emit(state.copyWith(listEvent: newListEvent));
  }

  void changeFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void changeSelected() {
    if (state.isSelected) {
      final listEvent = state.listEvent;
      int i;
      for (i = 0; i < listEvent.length; i++) {
        if (listEvent[i].isSelected) {
          final event = listEvent[i];
          listEvent[i] = event.copyWith(isSelected: !listEvent[i].isSelected);
        }
      }
      emit(state.copyWith(listEvent: listEvent, editText: '', isPicter: false));
    }
    emit(state.copyWith(isSelected: !state.isSelected));
  }

  void changeFavoriteItem() {
    final listEvent = state.listEvent;
    Event event;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        event = listEvent[i];
        listEvent[i] = event.copyWith(isFavorit: !listEvent[i].isFavorit);
      }
    }
    emit(state.copyWith(listEvent: listEvent));
    changeSelected();
  }

  void changeSelectedItem(int index) {
    final newlistEvent = state.listEvent;
    final event = state.listEvent[index];
    newlistEvent[index] =
        event.copyWith(isSelected: !newlistEvent[index].isSelected);
    if (newlistEvent[index].messageImage != null) {
      emit(state.copyWith(isPicter: !state.isPicter));
    }
    emit(state.copyWith(listEvent: newlistEvent));
  }

  void addPicterMessage({
    required XFile? pickedFile,
    required String type,
  }) {
    if (pickedFile != null) {
      final event = Event(
        messageContent: 'Image Entry',
        messageType: type,
        messageTime: DateTime.now(),
        messageImage: Image.file(
          File(pickedFile.path),
        ),
        isFavorit: false,
        isSelected: false,
      );
      final newListEvent = state.listEvent;
      newListEvent.insert(
        0,
        event,
      );
      emit(state.copyWith(listEvent: newListEvent));
    }
  }

  void deleteEvent() {
    final listEvent = state.listEvent;
    listEvent.removeWhere((element) => element.isSelected);
    emit(state.copyWith(listEvent: listEvent));
    changeSelected();
  }

  void changeEditText() {
    final listEvent = state.listEvent;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        emit(state.copyWith(editText: listEvent[i].messageContent));
        break;
      }
    }
  }

  void editEvent({required String content}) {
    final listEvent = state.listEvent;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        final event = listEvent[i];
        listEvent[i] = event.copyWith(messageContent: content);
        break;
      }
    }
    emit(state.copyWith(listEvent: listEvent));
    changeSelected();
  }
}
