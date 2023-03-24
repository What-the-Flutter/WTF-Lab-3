import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/repository/chat_repository_api.dart';
import 'package:diary_application/domain/repository/event_repository_api.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepositoryApi chatRepository;
  final EventRepositoryApi eventRepository;
  late final StreamSubscription<List<Chat>> chatsStream;

  HomeCubit({
    required this.chatRepository,
    required this.eventRepository,
  }) : super(HomeState(chats: [])) {
    _initState();
  }

  void _initState() async {
    final chats = await chatRepository.getChats();
    emit(state.copyWith(chats: chats));

    chatsStream = chatRepository.chatsStream.listen((chat) {
      chat.sort((a, b) => b.creationTime.compareTo(a.creationTime));
      emit(state.copyWith(chats: chat));
    });
  }

  void update() async {
    final chats = await chatRepository.getChats();
    emit(state.copyWith(chats: chats));
  }

  void add({required String title, required int iconNumber}) {
    final now = DateTime.now();
    final chat = Chat(
      id: '',
      title: title,
      events: [],
      iconNumber: iconNumber,
      creationTime: '$now',
      lastEvent: '',
      lastUpdate: '$now'
    );
    state.chats.add(chat);
    chatRepository.addChat(chat);

    emit(state.copyWith(chats: state.chats));
  }

  void delete(String id) async {
    final chat = state.chats.firstWhere((chat) => chat.id == id);
    state.chats.remove(chat);

    final trashEvents = await eventRepository.getEvents(id);
    for (Event event in trashEvents) {
      if (event.chatId == chat.id) {
        eventRepository.deleteEvent(event);
      }
    }
    chatRepository.deleteChat(chat);

    emit(state.copyWith(chats: state.chats));
  }

  void edit(String id, {required String title, required int iconNumber}) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(
      title: title,
      iconNumber: iconNumber,
    );
    chatRepository.changeChat(state.chats[index]);

    emit(state.copyWith(chats: state.chats));
  }

  void changePin(String id) {
    final index = _findIndexById(id);

    final isPin = state.chats[index].isPin;
    state.chats[index] = state.chats[index].copyWith(isPin: !isPin);
    chatRepository.changeChat(state.chats[index]);

    state.chats.sort((a, b) {
      if (b.isPin && a == b) {
        return a.creationTime.compareTo(b.creationTime);
      } else if (b.isPin) {
        return 1;
      } else {
        return -1;
      }
    });

    emit(state.copyWith(chats: state.chats));
  }

  void archive(String id, [bool isArchive = true]) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(isArchive: isArchive);
    chatRepository.changeChat(state.chats[index]);

    emit(state.copyWith(chats: state.chats));
  }

  int _findIndexById(String id) {
    final chats = state.chats;
    return chats.indexOf(chats.firstWhere((chat) => chat.id == id));
  }

  @override
  Future<void> close() {
    chatsStream.cancel();
    return super.close();
  }
}
