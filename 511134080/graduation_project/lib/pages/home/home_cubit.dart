import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    loadChats();
  }

  Future<void> loadChats() async {
    var chats = await state.chatRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }

  Future<void> updateChats(Chat newChat) async {
    final index = state._chats.indexWhere((Chat chat) => chat.id == newChat.id);

    if (index != -1) {
      await state.chatRepository.updateChat(newChat);
      final chats = await state.chatRepository.receiveAllChats();
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    } else {
      await state.chatRepository.insertChat(newChat);
      final chats = await state.chatRepository.receiveAllChats();
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    }
  }

  Future<void> deleteChat(String chatId) async {
    await state.chatRepository.deleteChatById(chatId);
    var chats = await state.chatRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }

  Future<void> togglePinState(String chatId) async {
    final chat = state._chats.where((Chat chat) => chat.id == chatId).first;

    await state.chatRepository.updateChat(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
    var chats = await state.chatRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }
}
