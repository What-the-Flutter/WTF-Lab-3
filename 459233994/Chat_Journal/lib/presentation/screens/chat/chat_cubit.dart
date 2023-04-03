import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/event_repository.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/repos/tag_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventRepositoryImpl _eventRepository;
  final TagRepository _tagRepository;

  ChatCubit({
    required eventRepository,
    required tagRepository,
  })  : _eventRepository = eventRepository,
        _tagRepository = tagRepository,
        super(ChatState(isLoaded: false)) {
    loadTags();
    _initListener();
  }

  void _initListener() {
    _eventRepository.initListener(updateChat);
    _tagRepository.initListener(updateTags);
  }

  void loadChat(Chat chat) async {
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
        isFilledTag: false,
      ),
    );
  }

  void updateChat() async {
    final events = await _eventRepository.getEvents(state.chat!.id!);
    if (state.chat != null) {
      emit(
        state.copyWith(
          chat: state.chat!.copyWith(events: events),
        ),
      );
    }
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
    print(state.isSearched);
  }

  void changeBottomBarState(String value) {
    value.isNotEmpty
        ? emit(state.copyWith(isInputFilled: true))
        : emit(state.copyWith(isInputFilled: false));
  }

  void changeTagSelectionBarState() {
    state.isFilledTag == false
        ? emit(state.copyWith(isFilledTag: true))
        : emit(state.copyWith(isFilledTag: false));
  }

  void addEventToChat(Event event) async {
    await _eventRepository.insertEvent(event);
  }

  List<Event> getEvents() {
    return state.chat!.events;
  }

  void editEvent({required Event editedEvent}) {
    _eventRepository.changeEvent(editedEvent);
  }

  void deleteEvent({required Event event}) {
    _eventRepository.deleteEvent(event);
  }

  Event getEventById(String id) {
    return state.chat!.events.firstWhere((element) => element.id == id);
  }

  Event getEventByIndex(int index) {
    return state.chat!.events[index];
  }

  void loadTags() async {
    final tags = await _tagRepository.getTags();
    emit(state.copyWith(tags: tags));
  }

  Future<String> insertTag(Tag tag) async {
    return await _tagRepository.insertTag(tag);
  }

  void updateTags() async {
    final tags = await _tagRepository.getTags();
    emit(state.copyWith(tags: tags));
  }
}
