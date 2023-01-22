import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';

class EventCubit extends Cubit<EventState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  EventCubit({this.user}) : super(EventState(listEvent: [])) {
    initializer();
  }

  Future<void> initializer() async {
    final listEvent = await firebase.getAllEvent();
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
      id: DateTime.now().millisecondsSinceEpoch,
      chatId: chatId,
      messageContent: content,
      messageType: type,
      messageTime: DateTime.now(),
      messageImage: null,
      sectionIcon: selectedIcon != Icons.bubble_chart ? selectedIcon : null,
      sectionTitle: selectedTitle != 'Cancel' ? selectedTitle : null,
      tag: state.tagTitle != 'Cancel' ? state.tagTitle : null,
    );
    await firebase.addEvent(newEvent);
    newListEvent.add(newEvent);
    emit(
      state.copyWith(
        listEvent: newListEvent,
        isWrite: false,
        tagTitle: 'Cancel',
      ),
    );
  }

  void resetFavorite() {
    emit(state.copyWith(isFavorite: false));
  }

  void changeFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  Future<void> changeSelected() async {
    if (state.isSelected) {
      final listEvent = state.listEvent;
      int i;
      for (i = 0; i < listEvent.length; i++) {
        if (listEvent[i].isSelected) {
          final event = listEvent[i];
          listEvent[i] = event.copyWith(isSelected: !listEvent[i].isSelected);
          await firebase.updateEvent(listEvent[i]);
        }
      }
      emit(state.copyWith(listEvent: listEvent, editText: '', isPicter: false));
    }
    emit(state.copyWith(isSelected: !state.isSelected, isFavorite: false));
  }

  Future<void> changeFavoriteItem() async {
    final listEvent = state.listEvent;
    Event event;
    int i;
    for (i = 0; i < listEvent.length; i++) {
      if (listEvent[i].isSelected) {
        event = listEvent[i];
        listEvent[i] = event.copyWith(isFavorit: !listEvent[i].isFavorit);
        await firebase.updateEvent(listEvent[i]);
      }
    }
    emit(state.copyWith(listEvent: listEvent));
    changeSelected();
  }

  Future<void> changeSelectedItem(int id) async {
    final newlistEvent = state.listEvent;
    final indexEvent = newlistEvent.indexWhere((element) => element.id == id);
    final event = state.listEvent.firstWhere((element) => element.id == id);
    newlistEvent[indexEvent] = event.copyWith(isSelected: !newlistEvent[indexEvent].isSelected);
    await firebase.updateEvent(newlistEvent[indexEvent]);
    if (newlistEvent[indexEvent].messageImage != null) {
      emit(state.copyWith(isPicter: !state.isPicter));
    }
    emit(state.copyWith(listEvent: newlistEvent));
    _changeCountSelected();
  }

  Future<void> addPicterMessage({
    String? repetFile,
    XFile? pickedFile,
    required String type,
    required int chatId,
  }) async {
    if (pickedFile != null || repetFile != null) {
      final newEvent = Event(
        id: UniqueKey().hashCode,
        chatId: chatId,
        messageContent: 'Image Entry',
        messageType: type,
        messageTime: DateTime.now(),
        messageImage: repetFile ?? pickedFile!.path,
        isFavorit: false,
        isSelected: false,
      );
      final newListEvent = state.listEvent;
      final event = await firebase.addEvent(newEvent);
      newListEvent.add(event);
      emit(state.copyWith(listEvent: newListEvent, isWrite: false));
    }
  }

  void changeWrite() {
    emit(state.copyWith(isWrite: true));
  }

  Future<void> deleteEvent([Event? event]) async {
    final listEvent = state.listEvent;
    int i;
    if (event != null) {
      listEvent.removeWhere((element) => element.id == event.id);
      await firebase.deleteEvent(event);
    } else {
      for (i = 0; i < listEvent.length; i++) {
        if (listEvent[i].isSelected) {
          await firebase.deleteEvent(listEvent[i]);
        }
      }
      listEvent.removeWhere((element) => element.isSelected);
      changeSelected();
    }
    emit(state.copyWith(listEvent: listEvent));
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
        await firebase.updateEvent(listEvent[i]);
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

  void changeStatusTag() {
    emit(state.copyWith(isTag: !state.isTag));
  }

  void changeSwitchSectionTag() {
    emit(state.copyWith(switchSectionTag: !state.switchSectionTag));
  }

  void _changeCountSelected() {
    final listElement = state.listEvent;
    final listSelected = listElement.where((element) => element.isSelected);
    emit(state.copyWith(countSelected: listSelected.length));
    if (state.countSelected == 0) {
      changeSelected();
    }
  }

  void changeTagTitle(String tag) {
    if (tag == 'Cancel') {
      emit(state.copyWith(tagTitle: 'Cancel'));
      changeStatusTag();
    } else {
      emit(state.copyWith(tagTitle: tag));
      changeStatusTag();
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

  Future<void> repetEvent({required int chatId, required List<Event> listEvent}) async {
    final newListEvent = listEvent.reversed.where((element) => element.isSelected).toList();
    final oldListEvent = state.listEvent;
    int i;
    for (i = 0; i < newListEvent.length; i++) {
      if (newListEvent[i].isSelected) {
        await firebase.updateEvent(newListEvent[i].copyWith(chatId: chatId, isSelected: false));
        oldListEvent.remove(newListEvent[i]);
        oldListEvent.add(newListEvent[i].copyWith(chatId: chatId, isSelected: false));
      }
    }
    emit(state.copyWith(listEvent: _listEventSort(oldListEvent)));
    changeSelected();
  }

  List<Event> _listEventSort(List<Event> listChat) {
    listChat.sort((a, b) => a.messageTime.compareTo(b.messageTime));
    return listChat;
  }

  Stream<DatabaseEvent>? getStream(User? user, int chatId) => FirebaseDatabase.instance
      .ref()
      .child(user?.uid ?? '')
      .child('event')
      .orderByChild('chatId')
      .equalTo(chatId)
      .onValue;

  List<Event> getEventList(AsyncSnapshot<DatabaseEvent> snapshot) {
    final Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
    final listEvent = <Event>[];
    for (final chatElement in map.values) {
      final map = chatElement as Map<dynamic, dynamic>;
      final event = Event.fromJson(map);
      listEvent.add(event);
    }
    final newEventList = listEvent.reversed.toList();
    newEventList.sort(
      (a, b) => b.messageTime.compareTo(a.messageTime),
    );
    return newEventList;
  }
}
