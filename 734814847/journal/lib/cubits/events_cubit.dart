import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../models/chat.dart';
import '../models/event.dart';
import 'chat_cubit.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit({required this.chatsCubit})
      : super(EventsState(Chat(icon: icons[0], name: '', key: const Key(''))));

  final ChatsCubit chatsCubit;

  void create(Chat chat) {
    final _chat = chatsCubit.state.chats
        .where((element) => element.key == chat.key)
        .first;
    emit(
      state.copyWith(updated: _chat),
    );
  }

  void update(Chat chat) {
    emit(
      state.copyWith(updated: chat),
    );
    chatsCubit.update(state.chat);
  }

  void favouriteEvent(Event event_) {
    final chat = state.chat;
    event_.isFavourite = !event_.isFavourite;
    final index = state.chat.events.indexOf(event_);
    chat.events[index] = event_;
    update(chat);
  }

  void errorChangeEvent() {
    final chat = state.chat;
    final index = state.chat.events.indexOf(
        state.chat.events.where((element) => element.isSelected).first);
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
      event.isSelected = false;
    }
    update(chat);
  }

  void changeEvent(String text) {
    final chat = state.chat;
    var index = state.chat.events.indexOf(
        state.chat.events.where((element) => element.isSelected).first);
    chat.events[index].text = text;
    chat.events[index].isSelected = false;
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    update(chat);
  }

  void selectedEvent(Event event_) {
    final chat = state.chat;
    if (event_.isSelected &&
        state.chat.events.where((element) => element.isSelected).length == 1) {
      for (var event in chat.events) {
        event.isSelectionProcess = false;
      }
    }
    final index = state.chat.events.indexOf(event_);
    chat.events[index].isSelected = !event_.isSelected;
    update(chat);
  }

  void selectionProcessHandler(Event event_) {
    final chat = state.chat;
    for (var event in chat.events) {
      event.isSelectionProcess = true;
    }
    final index = state.chat.events.indexOf(event_);
    chat.events[index].isSelected = true;
    update(chat);
  }

  Future copySelected() async {
    var result = '';
    final chat = state.chat;
    for (var event in chat.events.where((element) => element.isSelected)) {
      result += '${event.text}\n';
      event.isSelected = false;
    }
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    update(chat);
    await Clipboard.setData(ClipboardData(text: result));
  }

  void deleteEvents() {
    final chat = state.chat;
    chat.events.removeWhere((element) => element.isSelected);
    for (var event in chat.events) {
      event.isSelectionProcess = false;
    }
    update(chat);
  }

  void addEvent(Event event) {
    final chat = state.chat;
    chat.events = List<Event>.from(chat.events)..add(event);
    update(chat);
  }

  void changeChat(Chat newChat) {
    final chat = state.chat;
    final selected = List<Event>.from(
      chat.events.where((card) => card.isSelected),
    );
    final movedChat = List<Event>.from(newChat.events..addAll(selected));
    final updatedChat = List<Event>.from(
      chat.events.where((card) => !card.isSelected),
    );

    for (var event in updatedChat) {
      event.isSelectionProcess = false;
      event.isSelected = false;
    }
    for (var event in movedChat) {
      event.isSelectionProcess = false;
      event.isSelected = false;
    }
    chat.events = updatedChat;
    newChat.events = movedChat;

    emit(state.copyWith(updated: chat));
    chatsCubit.update(newChat);
  }
}
