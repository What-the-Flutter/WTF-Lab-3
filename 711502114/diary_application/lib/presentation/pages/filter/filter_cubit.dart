import 'dart:async';

import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/repository/chat_repository_api.dart';
import 'package:diary_application/domain/repository/event_repository_api.dart';
import 'package:diary_application/presentation/pages/filter/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  final ChatRepositoryApi chatRepo;
  final EventRepositoryApi eventRepo;
  late final StreamSubscription _stream;

  FilterCubit({
    required ChatRepositoryApi chatRepositoryApi,
    required EventRepositoryApi eventRepositoryApi,
  })  : chatRepo = chatRepositoryApi,
        eventRepo = eventRepositoryApi,
        super(
          const FilterState(
            chats: [],
            chatTitles: [],
            isIgnore: false,
          ),
        ) {
    _init();
  }

  void _init() async {
    initChats();
    _stream = chatRepo.chatsStream.listen((c) {
      emit(state.copyWith(chats: c.toList()));
    });
  }

  void initChats() async {
    final chats = await chatRepo.getChats();
    emit(state.copyWith(chats: chats));
  }

  void changeIgnoreStatus(bool isIgnore) {
    emit(state.copyWith(isIgnore: isIgnore));
  }

  Future<List<Event>> filterChats({String lookFor = ''}) async {
    List<Event> events = await eventRepo.getAllEvents();
    if (state.chatTitles.isEmpty) {
      return lookFor.isEmpty ? events : _filterListByKeyWords(events, lookFor);
    }

    if (state.isIgnore) {
      for (final chat in state.chatTitles) {
        events = events.where((e) => e.chatId != chat).toList();
      }
    } else {
      final bufferList = <Event>[];
      for (final chat in state.chatTitles) {
        bufferList.addAll(events.where((e) => e.chatId == chat));
      }
      events = [...bufferList];
    }

    if (lookFor.isNotEmpty) events = _filterListByKeyWords(events, lookFor);
    return events;
  }

  List<Event> _filterListByKeyWords(List<Event> events, String keyWord) {
    final it = events.where((e) => e.message.toLowerCase().contains(keyWord));
    return it.toList();
  }

  void addOrDeleteFilterSettings(String chatId) {
    final chatTitles = [...state.chatTitles];
    if (chatTitles.contains(chatId)) {
      chatTitles.remove(chatId);
    } else {
      chatTitles.add(chatId);
    }
    emit(state.copyWith(chatTitles: chatTitles));
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
