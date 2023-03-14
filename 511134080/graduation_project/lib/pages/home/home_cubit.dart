import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeState initState}) : super(initState);

  void updateChats(ChatModel newChat) {
    final index =
        state._chats.indexWhere((ChatModel chat) => chat.id == newChat.id);
    if (index != -1) {
      final chats = state._chats;
      chats[index] = newChat;
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    } else {
      final chats = List<ChatModel>.from([newChat])..addAll(state._chats);

      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    }
  }

  void deleteChat(dynamic chatId) {
    final chats = List<ChatModel>.from(state._chats)
      ..removeWhere((ChatModel chat) => chat.id == chatId);
    emit(state.copyWith(newChats: chats));
  }

  void togglePinState(dynamic chatId) {
    final chat =
        state._chats.where((ChatModel chat) => chat.id == chatId).first;

    updateChats(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
  }
}
