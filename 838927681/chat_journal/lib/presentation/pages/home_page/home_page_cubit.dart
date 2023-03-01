import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final ApiChatRepository _chatRepository;
  final ApiEventRepository _eventRepository;
  late final StreamSubscription<List<Chat>> _chatsStream;

  HomePageCubit({
    required ApiEventRepository eventRepository,
    required ApiChatRepository chatRepository,
  })  : _eventRepository = eventRepository,
        _chatRepository = chatRepository,
        super(const HomePageState(chats: [])) {
    init();
  }

  void init() async {
    final chats = await _chatRepository.getChats();
    emit(state.copyWith(chats: chats));
    _chatsStream = _chatRepository.chatsStream.listen(
      (event) {
        event.sort((a, b) => b.lastDate.compareTo(a.lastDate));
        emit(state.copyWith(chats: event));
      },
    );
  }

  Future<void> updateChats() async {
    final chats = await _chatRepository.getChats();
    emit(state.copyWith(chats: chats));
  }

  void addChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.add(chat);
    emit(state.copyWith(chats: chats));
    _chatRepository.addChat(chat);
  }

  void deleteChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.remove(chat);
    _chatRepository.removeChat(chat);
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

  Future<DateTime> _lastDate(String id) async {
    final events = await _eventRepository.getEvents(id);
    return events.last.dateTime;
  }

  String getLastEventText(int i) {
    return state.lastEvent != null
        ? state.lastEvent!.text
        : 'No events. Click to create one';
  }

  @override
  Future<void> close() {
    _chatsStream.cancel();
    return super.close();
  }
}
