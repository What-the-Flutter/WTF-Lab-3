import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventState(listEvent: []));

  void initializer(List<Event> event) {
    emit(state.copyWith(listEvent: event));
  }

  void addEvent({
    required String content,
    required String type,
  }) {
    final selectedIcon = state.sectionIcon;
    final sectionTitle = state.sectionTitle;
    final newListEvent = state.listEvent;
    final event = Event(
      id: UniqueKey().hashCode,
      messageContent: content,
      messageType: type,
      messageTime: DateTime.now(),
      isFavorit: false,
      isSelected: false,
      sectionIcon: selectedIcon != Icons.bubble_chart ? selectedIcon : null,
      sectionTitle: sectionTitle != 'Cancel' ? sectionTitle : null,
    );
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

  void changeSelectedItem(int id) {
    final newlistEvent = state.listEvent;
    final indexEvent = newlistEvent.indexWhere((element) => element.id == id);
    final event = state.listEvent.firstWhere((element) => element.id == id);
    newlistEvent[indexEvent] = event.copyWith(isSelected: !newlistEvent[indexEvent].isSelected);
    if (newlistEvent[indexEvent].messageImage != null) {
      emit(state.copyWith(isPicter: !state.isPicter));
    }
    emit(state.copyWith(listEvent: newlistEvent));
    _changeCountSelected();
  }

  void addPicterMessage({
    required XFile? pickedFile,
    required String type,
  }) {
    if (pickedFile != null) {
      final event = Event(
        id: state.listEvent.length,
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
      print(newListEvent == state.listEvent);
      newListEvent.insert(
        0,
        event,
      );

      emit(state.copyWith(listEvent: newListEvent));
    }
  }

  void deleteEvent([int id = -1]) {
    final listEvent = state.listEvent;
    if (id != -1) {
      listEvent.removeWhere((element) => element.id == id);
    } else {
      listEvent.removeWhere((element) => element.isSelected);
    }
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

  void changeSearch() {
    if (state.isSearch) {
      emit(state.copyWith(isSearch: false, searchText: ''));
    } else {
      emit(state.copyWith(isSearch: true));
    }
  }

  void changeSection() {
    emit(state.copyWith(isSection: !state.isSection));
  }

  void _changeCountSelected() {
    final listElement = state.listEvent;
    final listSelected = listElement.where((element) => element.isSelected);
    emit(state.copyWith(countSelected: listSelected.length));
    if (state.countSelected == 0) {
      changeSelected();
    }
  }

  void changeSectionIcon({
    required IconData icon,
    required String sectionTitle,
  }) {
    final iconCancel = Icons.cancel;
    if (icon == iconCancel) {
      emit(state.copyWith(
        sectionIcon: Icons.bubble_chart,
        sectionTitle: 'Cancel',
      ));
      changeSection();
    } else {
      emit(state.copyWith(
        sectionIcon: icon,
        sectionTitle: sectionTitle,
      ));
      changeSection();
    }
  }

  void copyClipboard() async {
    final event = state.listEvent.firstWhere((element) => element.isSelected);
    final copyText = event.messageContent;
    await Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );
    changeSelected();
  }

  List<Event> searchListEvent() {
    final list = state.listEvent
        .where((element) => element.messageContent.toLowerCase().contains(state.searchText))
        .toList();
    return list;
  }

  void searchText(String text) {
    emit(state.copyWith(searchText: text));
  }
}
