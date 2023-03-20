import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/event_repository.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventRepositoryImpl _eventRepository;

  ChatCubit({required eventRepository})
      : _eventRepository = eventRepository,
        super(ChatState(isLoaded: false)) {
    eventRepository.dataBaseService.databaseRef
        .child(eventRepository.dataBaseService.fireBaseAuth.currentUser!.uid)
        .child('events')
        .onValue
        .listen((event) {
      updateChat();
    });
  }

  void loadChat(Chat chat) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final events = await _eventRepository.getEvents(chat.id!);
    chat.events.clear();
    chat.events.addAll(events);
    emit(
      state.copyWith(
        chat: chat,
        isFavorite: false,
        isSearched: false,
        isLoaded: true,
        isInputFilled: false,
      ),
    );
  }

  void updateChat() async {
    final events = await _eventRepository.getEvents(state.chat!.id!);
    state.chat?.events.clear();
    state.chat?.events.addAll(events);
    emit(state.copyWith());
  }

  void editEvent({required Event editedEvent}) {
    _eventRepository.changeEvent(editedEvent);
  }

  void deleteEvent({required Event event}) {
    _eventRepository.deleteEvent(event);
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

  void changeBottomBarState(String value) {
    value.isNotEmpty
        ? emit(state.copyWith(isInputFilled: true))
        : emit(state.copyWith(isInputFilled: false));
  }

  void addEventToChat(Event event) async {
    await _eventRepository.insertEvent(event);
  }

  List<Event> getEvents() {
    return state.chat!.events;
  }

  Event getEventById(String id) {
    return state.chat!.events.firstWhere((element) => element.id == id);
  }

  Event getEventByIndex(int index) {
    return state.chat!.events[index];
  }
}
