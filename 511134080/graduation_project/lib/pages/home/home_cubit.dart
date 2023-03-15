import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeState initState}) : super(initState);

  void updateChats(Chat newChat) {
    final index = state._chats.indexWhere((Chat chat) => chat.id == newChat.id);

    if (index != -1) {
      final chats = state._chats;
      chats[index] = newChat;
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    } else {
      final chats = List<Chat>.from([newChat])..addAll(state._chats);

      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    }
  }

  void deleteChat(dynamic chatId) {
    final chats = List<Chat>.from(state._chats)
      ..removeWhere((Chat chat) => chat.id == chatId);
    emit(state.copyWith(newChats: chats));
  }

  void togglePinState(dynamic chatId) {
    final chat = state._chats.where((Chat chat) => chat.id == chatId).first;

    updateChats(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
  }
}
