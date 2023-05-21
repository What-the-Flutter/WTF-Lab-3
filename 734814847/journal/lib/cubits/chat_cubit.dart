import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/chat.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({required ChatsState chatsState}) : super(chatsState);

  void update(Chat chat) {
    final index = state.chats.indexWhere((element) => element.key == chat.key);
    final List<Chat> chats;
    if (index == -1) {
      chats = List<Chat>.from([chat])..addAll(state.chats);
    } else {
      chats = state.chats;
      chats[index] = chat;
    }
    emit(
      state.copyWith(
        updated: chats,
      ),
    );
  }

  void delete(Chat chat) {
    final chats = state.chats;
    chats.removeWhere((element) => element.key == chat.key);
    emit(
      state.copyWith(
        updated: chats,
      ),
    );
  }
}
