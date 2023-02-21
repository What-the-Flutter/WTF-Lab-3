import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatNotLoaded());

  void loadChat(Chat chat) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    emit(ChatLoaded(chat: chat, isFavorite: false));
  }

  void updateChat(){
    var state = this.state;
    if (state is ChatLoaded) {
      emit(ChatLoaded(chat: state.chat, isFavorite: state.isFavorite));
    }
  }

  void changeFavoriteState() {
    var state = this.state;
    if (state is ChatLoaded) {
      state.isFavorite
          ? emit(state.copyWith(isFavorite: false))
          : emit(state.copyWith(isFavorite: true));
    }
  }

  void addEventToChat(Event event) {
    var state = this.state;
    if (state is ChatLoaded) {
      state.chat.events.add(event);
      emit(
        ChatLoaded(
          chat: state.chat,
          isFavorite: state.isFavorite,
        ),
      );
    }
  }

  List<Event> getEvents() {
    var state = this.state;
    if (state is ChatLoaded) {
      return state.chat.events;
    } else {
      throw 'chat is empty';
    }
  }
}
