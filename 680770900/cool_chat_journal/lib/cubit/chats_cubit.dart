import 'package:bloc/bloc.dart';

import '../model/chat.dart';
import '../model/chats_state.dart';
import '../model/event.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({required initialState}) : super(initialState);

  void addNewChat(Chat newChat) {
    final chats = List<Chat>.from(state.chats)
      ..add(newChat);

    emit(state.copyWith(chats: chats));
  }

  void deletedChat(int index) {
    final chats = List<Chat>.from(state.chats)
      ..removeAt(index);

    emit(state.copyWith(chats: chats));
  }

  void editChat(int index, Chat newChat) {
    final chats = List<Chat>.from(state.chats);
    chats[index] = newChat;

    emit(state.copyWith(chats: chats)); 
  }

  void pinChat(int index) {
    final pinnedChats = Map<int, bool>.from(state.pinnedChats);

    if (pinnedChats[index] == true) {
      pinnedChats[index] = false;
    } else {
      pinnedChats[index] = true;
    }

    emit(state.copyWith(pinnedChats: pinnedChats));
  }

  void resetSelection() {
    final pinnedChats = Map<int, bool>.from(state.pinnedChats);

    for (final index in pinnedChats.keys) {
      pinnedChats[index] = false;
    }

    emit(state.copyWith(pinnedChats: pinnedChats));
  }

  void addEvent(int chatIndex, Event event) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events)
      ..add(event);

    editChat(chatIndex, chat.copyWith(events: events));
  }

  void editEvent(int chatIndex, int eventIndex, Event event) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events);
    events[eventIndex] = event;

    editChat(chatIndex, chat.copyWith(events: events));
  }

  void deleteEvent(int chatIndex, int eventIndex) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events)
      ..removeAt(eventIndex);


    editChat(chatIndex, chat.copyWith(events: events));
  }

  void deleteEvents(int chatIndex, Iterable<int> eventsIndexes) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events);

    final deletedEvents = <Event>[];

    for (final i in eventsIndexes) {
      deletedEvents.add(events[i]);
    }

    for (final event in deletedEvents) {
      events.remove(event);
    }

    editChat(chatIndex, chat.copyWith(events: events));
  }

  void markFavoriteEvent(int chatIndex, int eventIndex) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events);

    final oldEvent = events[eventIndex];
    events[eventIndex] = oldEvent.copyWith(
      isFavorite: !oldEvent.isFavorite,
    );

    editChat(chatIndex, chat.copyWith(events: events));
  }

  void transferEvent(int sourceIndex, int destinationIndex, int eventIndex) {
    final event = state.chats[sourceIndex].events[eventIndex];

    addEvent(destinationIndex, event);
    deleteEvent(sourceIndex, eventIndex);
  }

  void transferEvents(int source, int destination, Iterable<int> events) {
    for (final i in events) {
      final event = state.chats[source].events[i];
      addEvent(destination, event);
    }

    deleteEvents(source, events);
  }
}