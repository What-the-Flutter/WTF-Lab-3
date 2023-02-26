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

  void addNewTextEvent(int chatIndex, String text) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events)
      ..add(Event(
        content: text,
        changeTime: DateTime.now()
      ));

    editChat(chatIndex, chat.copyWith(events: events));
  }

  void editTextEvent(int chatIndex, int index, String newText) {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events);

    final oldEvent = events[index];
    events[index] = oldEvent.copyWith(
      content: newText,
    );

    editChat(chatIndex, chat.copyWith(events: events));
  }

  Future<void> addNewImageEvent(int chatIndex, String imagePath) async {
    final chat = state.chats[chatIndex];
    final events = List<Event>.from(chat.events)
      ..add(Event(
        content: imagePath,
        isImage: true,
        changeTime: DateTime.now()
      ));

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
}