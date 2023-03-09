import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    loadChats();
  }

  Future<void> addChat({required Chat chat}) async {
    await state.chatRepository.insertChat(chat);
    emit(HomeState(chats: await state.chatRepository.getChats()));
  }

  void editChat({
    required Chat editedChat,
  }) async {
    state.chatRepository.changeChat(editedChat);
    emit(HomeState(chats: await state.chatRepository.getChats()));
  }

  void deleteChat({required Chat chat}) async{
    state.chatRepository.deleteChat(chat);
    emit(HomeState(chats: await state.chatRepository.getChats()));
  }

  void pinChat({required Chat chat}) async{
    state.chatRepository.changeChat(chat);
    emit(HomeState(chats: await state.chatRepository.getChats()));
  }

  Future<void> loadChats() async {
    var chats = await state.chatRepository.getChats();
    state.chats.addAll(chats);
    emit(HomeState(chats: chats));
  }

  List<Chat> getChats() {
    return state.chats;
  }

  Chat getChat(int index){
    return state.chats[index];
  }
}
