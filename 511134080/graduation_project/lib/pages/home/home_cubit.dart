import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/chat_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeState initState}) : super(initState);

  void updateChats(ChatModel newChat) {
    final index =
        state.chats.indexWhere((ChatModel chat) => chat.id == newChat.id);
    if (index != -1) {
      final chats = state.chats;
      chats[index] = newChat;

      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    } else {
      final chats = List<ChatModel>.from([newChat])..addAll(state.chats);

      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    }
  }

  void deleteChat(chatId) {
    final chats = List<ChatModel>.from(state.chats)
      ..removeWhere((ChatModel chat) => chat.id == chatId);
    emit(state.copyWith(newChats: chats));
  }

  void togglePinState(chatId) {
    final chat = state.chats.where((ChatModel chat) => chat.id == chatId).first;

    updateChats(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
  }
}
