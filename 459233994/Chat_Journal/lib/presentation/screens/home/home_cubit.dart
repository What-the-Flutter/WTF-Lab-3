import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void addChat({required Chat chat}) {
    state.chats.add(chat);
    emit(HomeState(chats: state.chats));
  }

  void editChat({
    required Chat oldChat,
    required Chat editedChat,
  }) {
    state.chats[state.chats.indexOf(oldChat)] = editedChat;
    emit(HomeState(chats: state.chats));
  }

  void deleteChat({required Chat chat}) {
    state.chats.removeAt(state.chats.indexOf(chat));
    emit(HomeState(chats: state.chats));
  }

  void pinChat({required Chat chat}) {
    state.chats[state.chats.indexOf(chat)] =
        state.chats[state.chats.indexOf(chat)].copyWith(
      isPinned: !state.chats[state.chats.indexOf(chat)].isPinned,
    );
    emit(HomeState(chats: state.chats));
  }

  List<Chat> getChats(){
    return state.chats;
  }
}
