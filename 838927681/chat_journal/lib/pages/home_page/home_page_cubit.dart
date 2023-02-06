import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(List<Chat> chats) : super(HomePageState(chats: chats)) {
    loadChats(chats);
  }

  void loadChats(List<Chat> chats) {
    emit(state.copyWith(chats: chats));
  }

  void updateChats(Chat chat, int i) {
    final chats = List<Chat>.from(state.chats);
    chats[i] = chats[i].copyWith(
      events: chat.events,
      iconIndex: chat.iconIndex,
      name: chat.name,
    );
    emit(state.copyWith(chats: chats));
  }

  void addChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.add(chat);
    emit(state.copyWith(chats: chats));
  }

  void deleteChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.remove(chat);
    emit(state.copyWith(chats: chats));
  }

  void addEventToChat(int? i, Event event) {
    final chats = state.chats;
    if (i != null) {
      state.chats[i].events.add(event);
      emit(state.copyWith(chats: chats));
    }
  }

  void sortEvents(int index) {
    final chats = List<Chat>.from(state.chats);
    final events = List<Event>.from(chats[index].events);
    events.sort(
      (a, b) {
        return a.dateTime.compareTo(b.dateTime);
      },
    );
    chats[index] = chats[index].copyWith(events: events);
    emit(state.copyWith(chats: chats));
  }

  void sortChats() {
    final chats = List<Chat>.from(state.chats);
    chats.sort(
      (a, b) {
        return b.lastDate.compareTo(a.lastDate);
      },
    );
    emit(state.copyWith(chats: chats));
  }
}
