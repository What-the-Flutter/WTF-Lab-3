import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final ApiChatRepository _chatRepository;
  final ApiEventRepository _eventRepository;
  late final StreamSubscription _chatStream;

  FilterCubit({
    required ApiChatRepository chatRepository,
    required ApiEventRepository eventRepository,
  })  : _chatRepository = chatRepository,
        _eventRepository = eventRepository,
        super(
          const FilterState(
            ignoreSelected: false,
            chats: [],
            filterChats: [],
          ),
        ) {
    _init();
  }

  void _init() async {
    final chats = await _chatRepository.getChats();
    emit(state.copyWith(chats: chats));
    _chatStream = _chatRepository.chatsStream.listen((event) {
      final chats = event.toList();
      emit(state.copyWith(chats: chats));
    });
  }

  Future<List<Event>> filterByChats({String search = ''}) async {
    var events = await _eventRepository.getAllEvents();
    if (state.filterChats.isEmpty && search == '') {
      return await _eventRepository.getAllEvents();
    }
    if (state.ignoreSelected) {
      for (final chat in state.filterChats) {
        events = events.where((element) => element.parentId != chat).toList();
      }
    } else {
      for (final chat in state.filterChats) {
        events = events.where((element) => element.parentId == chat).toList();
      }
    }
    events = events.where((element) => element.text.contains(search)).toList();
    return events;
  }

  void changeIgnoreSelected(bool value) =>
      emit(state.copyWith(ignoreSelected: value));

  void addOrRemoveFilter(String chatId) {
    final filterChats = List<String>.from(state.filterChats);
    if (filterChats.contains(chatId)) {
      filterChats.remove(chatId);
    } else {
      filterChats.add(chatId);
    }
    emit(state.copyWith(filterChats: filterChats));
  }

  bool isSelected(String chatId) {
    return state.filterChats.contains(chatId);
  }

  @override
  Future<void> close() {
    _chatStream.cancel();
    return super.close();
  }
}
