import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/data/db/db_provider.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';

class EventCubit extends Cubit<EventState> {
  final myDBProvider = DBProvider.dbProvider;

  EventCubit() : super(EventState(listEvent: [])) {
    initializer();
  }

  Future<void> initializer() async {
    final listEvent = await myDBProvider.getAllEvent();
    emit(state.copyWith(listEvent: listEvent));
  }

  Future<void> addEvent({
    required String content,
    required String type,
    required int chatId,
    IconData? sectionIcon,
    String? sectionTitle,
  }) async {
    final selectedIcon = sectionIcon ?? state.sectionIcon;
    final selectedTitle = sectionTitle ?? state.sectionTitle;
    final newListEvent = state.listEvent;
    final newEvent = Event(
      chatId: chatId,
      messageContent: content,
      messageType: type,
      messageTime: DateTime.now(),
      messageImage: null,
      sectionIcon: selectedIcon != Icons.bubble_chart ? selectedIcon : null,
      sectionTitle: selectedTitle != 'Cancel' ? selectedTitle : null,
    );
    final event = await myDBProvider.addEvent(newEvent);
    newListEvent.add(event);
    emit(state.copyWith(listEvent: newListEvent, isWrite: false));
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

  Future<void> changeFavoriteItem() async {
    final listEvent = state.listEvent;
    Event event;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        event = listEvent[i];
        listEvent[i] = event.copyWith(isFavorit: !listEvent[i].isFavorit);
        await myDBProvider.updateEvent(listEvent[i]); // dpProvider присвоить переменной
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

  Future<void> addPicterMessage({
    File? repetFile,
    XFile? pickedFile,
    required String type,
    required int chatId,
  }) async {
    if (pickedFile != null || repetFile != null) {
      final newEvent = Event(
        chatId: chatId,
        messageContent: 'Image Entry',
        messageType: type,
        messageTime: DateTime.now(),
        messageImage: repetFile ?? File(pickedFile!.path),
        isFavorit: false,
        isSelected: false,
      );
      final newListEvent = state.listEvent;
      final event = await myDBProvider.addEvent(newEvent);
      newListEvent.add(event);
      emit(state.copyWith(listEvent: newListEvent, isWrite: false));
    }
  }

  void changeWrite() {
    emit(state.copyWith(isWrite: true));
  }

  Future<void> deleteEvent([int id = -1]) async {
    final listEvent = state.listEvent;
    int i;
    if (id != -1) {
      listEvent.removeWhere((element) => element.id == id);
      await myDBProvider.deleteEventById(id);
    } else {
      for (i = 0; i < listEvent.length; i++) {
        if (listEvent[i].isSelected) {
          await myDBProvider.deleteEventById(listEvent[i].id!);
        }
      }
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

  Future<void> editEvent({required String content}) async {
    final listEvent = state.listEvent;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        final event = listEvent[i];
        listEvent[i] = event.copyWith(messageContent: content);
        await myDBProvider.updateEvent(listEvent[i]);
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

  void changeRepetStatus() {
    emit(state.copyWith(isRepet: !state.isRepet));
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

  Future<void> copyClipboard() async {
    final event = state.listEvent.firstWhere((element) => element.isSelected);
    final copyText = event.messageContent;
    await Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );
    changeSelected();
  }

  List<Event> searchListEvent(int chatId) {
    final list = state.listEvent.reversed
        .where((element) =>
            element.messageContent.toLowerCase().contains(state.searchText) &&
            element.chatId == chatId)
        .toList();
    return list;
  }

  void searchText(String text) {
    emit(state.copyWith(searchText: text));
  }

  void repetEvent({required int chatId, required List<Event> listEvent}) {
    final newListEvent = listEvent.reversed.where((element) => element.isSelected).toList();
    int i;
    for (i = 0; i < newListEvent.length; i++) {
      if (newListEvent[i].isSelected && newListEvent[i].messageImage != null) {
        addPicterMessage(
          repetFile: newListEvent[i].messageImage,
          type: newListEvent[i].messageType,
          chatId: chatId,
        );
      } else {
        addEvent(
          content: newListEvent[i].messageContent,
          type: newListEvent[i].messageType,
          chatId: chatId,
          sectionIcon: newListEvent[i].sectionIcon,
          sectionTitle: newListEvent[i].sectionTitle,
        );
      }
    }
  }
}
