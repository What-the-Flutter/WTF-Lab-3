import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState(chats: []));

  void loadChats(List<Chat> chats) {
    emit(state.copyWith(chats: chats));
  }

  void updateChats(Chat chat, int i) {
    var chats = state.chats;
    chats[i] = chat;
    emit(state.copyWith(chats: chats));
  }

  void addChat(Chat chat) {
    var chats = state.chats;
    chats.add(chat);
    emit(state.copyWith(chats: chats));
  }

  void deleteChat(Chat chat) {
    var chats = state.chats;
    chats.remove(chat);
    emit(state.copyWith(chats: chats));
  }
}
