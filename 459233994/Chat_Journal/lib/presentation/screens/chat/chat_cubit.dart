import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState(isLoaded: false));

  void loadChat(Chat chat) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    var events = await state.eventRepository.getEvents(chat.id!);
    chat.events.clear();
    chat.events.addAll(events);
    emit(
      state.copyWith(
        chat: chat,
        isFavorite: false,
        isSearched: false,
        isLoaded: true,
      ),
    );
  }

  void updateChat() async {
    var events = await state.eventRepository.getEvents(state.chat!.id!);
    state.chat?.events.clear();
    state.chat?.events.addAll(events);
    emit(state.copyWith());
  }

  void editEvent({required Event editedEvent}) {
    state.eventRepository.changeEvent(editedEvent);
    updateChat();
  }

  void deleteEvent({required Event event}){
    state.eventRepository.deleteEvent(event);
    updateChat();
  }

  void changeFavoriteState() {
    state.isFavorite == true
        ? emit(state.copyWith(isFavorite: false))
        : emit(state.copyWith(isFavorite: true));
  }

  void changeSearchedState() {
    state.isSearched == true
        ? emit(state.copyWith(isSearched: false))
        : emit(state.copyWith(isSearched: true));
  }

  void addEventToChat(Event event) async {
    await state.eventRepository.insertEvent(event);
    updateChat();
  }

  List<Event> getEvents() {
    return state.chat!.events;
  }

  Event getEventById(int id) {
    return state.chat!.events.firstWhere((element) => element.id == id);
  }

  Event getEventByIndex(int index){
    return state.chat!.events[index];
  }
}
