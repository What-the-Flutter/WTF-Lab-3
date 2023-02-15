import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../../../domain/repositories/api_event_repository.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final ApiChatRepository chatRepository;
  final ApiEventRepository eventRepository;
  late final StreamSubscription<List<Chat>> chatsStream;

  HomePageCubit({
    required this.eventRepository,
    required this.chatRepository,
  }) : super(const HomePageState(chats: [])) {
    init();
  }

  void init() async {
    final chats = await chatRepository.getChats();
    emit(state.copyWith(chats: chats));
    chatsStream = chatRepository.chatsStream.listen(
      (event) {
        event.sort((a, b) => b.lastDate.compareTo(a.lastDate));
        emit(state.copyWith(chats: event));
      },
    );
  }

  Future<void> updateChats() async {
    final chats = await chatRepository.getChats();
    emit(state.copyWith(chats: chats));
  }

  void addChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.add(chat);
    chatRepository.addChat(chat);
    emit(state.copyWith(chats: chats));
  }

  void deleteChat(Chat chat) {
    final chats = List<Chat>.from(state.chats);
    chats.remove(chat);
    chatRepository.removeChat(chat);
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
    final events = await eventRepository.getEvents(id);
    return events.last.dateTime;
  }

  String getLastEventText(int i) {
    return state.lastEvent != null
        ? state.lastEvent!.text
        : 'No events. Click to create one';
  }
}
