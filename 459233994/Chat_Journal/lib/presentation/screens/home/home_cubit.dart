import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/chat_repository.dart';
import '../../../domain/entities/chat.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepositoryImpl _chatRepository;

  HomeCubit({required chatRepository})
      : _chatRepository = chatRepository,
        super(HomeState()) {
    loadChats();
    _chatRepository.dataBaseService.databaseRef
        .child(_chatRepository.dataBaseService.fireBaseAuth.currentUser!.uid)
        .child('chats')
        .onValue
        .listen(
      (event) {
        loadChats(); //TODO peredelat
      },
    );
  }

  Future<void> addChat({required Chat chat}) async {
    await _chatRepository.insertChat(chat);
  }

  void editChat({
    required Chat editedChat,
  }) async {
    _chatRepository.changeChat(editedChat);
  }

  void deleteChat({required Chat chat}) async {
    _chatRepository.deleteChat(chat);
  }

  void pinChat({required Chat chat}) async {
    _chatRepository.changeChat(chat);
  }

  Future<void> loadChats() async {
    final chats = await _chatRepository.getChats();
    state.chats.addAll(chats);
    emit(HomeState(chats: chats));
  }

  List<Chat> getChats() {
    return state.chats;
  }

  Chat getChat(int index) {
    return state.chats[index];
  }
}
