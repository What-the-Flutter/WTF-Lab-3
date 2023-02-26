// ignore_for_file: omit_local_variable_types

import 'package:bloc/bloc.dart';

import '../../database/repository/chat_repository_api.dart';
import '../../database/repository/event_repository_api.dart';
import '../../models/chat.dart';
import '../../models/event.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepositoryApi chatRepository;
  final EventRepositoryApi eventRepository;

  HomeCubit({
    required this.chatRepository,
    required this.eventRepository,
    int id = 0,
  }) : super(HomeState(chats: [], id: id)) {
    _initState();
  }

  void _initState() async {
    final chats = await chatRepository.getChats();
    emit(state.copyWith(chats: chats));

    if (chats.isNotEmpty) {
      final lastId = chats.last.id;
      emit(state.copyWith(id: lastId));
    }
  }

  void update() {
    emit(state.copyWith(chats: state.chats));
  }

  void add({required String title, required int iconNumber}) {
    final id = state.id + 1;
    final chat = Chat(
      id: state.id + 1,
      title: title,
      events: [],
      iconNumber: iconNumber,
      creationTime: '${DateTime.now()}',
    );
    state.chats.add(chat);
    chatRepository.addChat(chat);

    emit(state.copyWith(chats: state.chats, id: id));
  }

  void delete(int id) async {
    final chat = state.chats.firstWhere((chat) => chat.id == id);
    state.chats.remove(chat);

    final trashEvents = await eventRepository.getEvents();
    for (Event event in trashEvents) {
      if (event.chatId == chat.id) {
        eventRepository.deleteEvent(event);
      }
    }
    chatRepository.deleteChat(chat);

    emit(state.copyWith(chats: state.chats));
  }

  void edit(int id, {required String title, required int iconNumber}) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(
      title: title,
      iconNumber: iconNumber,
    );
    chatRepository.changeChat(state.chats[index]);

    emit(state.copyWith(chats: state.chats));
  }

  void changePin(int id) {
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

  void archive(int id, [bool isArchive = true]) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(isArchive: isArchive);
    chatRepository.changeChat(state.chats[index]);

    emit(state.copyWith(chats: state.chats));
  }

  int _findIndexById(int id) {
    final chats = state.chats;
    return chats.indexOf(chats.firstWhere((chat) => chat.id == id));
  }
}
