import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../data/repos/chat_repository.dart';
import '../../../domain/entities/chat.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepositoryImpl _chatRepository;
  late final StreamSubscription _streamSubscription;

  HomeCubit({required chatRepository})
      : _chatRepository = chatRepository,
        super(HomeState()) {
    loadChats();
    initHomeListener();
  }

  void initHomeListener() async {
    _streamSubscription = await _chatRepository.initListener();
    _streamSubscription.onData(
          (data) {
        loadChats();
      },
    );
  }

  void disposeChatListener() async {
    _streamSubscription.cancel();
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
    emit(HomeState(chats: chats));
  }

  List<Chat> getChats() {
    return state.chats;
  }

  Chat getChat(int index) {
    return state.chats[index];
  }
}
