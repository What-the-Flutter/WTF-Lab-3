import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    loadChats();
  }

  Future<void> loadChats() async {
    final chats = await state.chatsRepository.receiveAllChats();
    for (var i = 0; i < chats.length; i++) {
      final events =
          await state.eventsRepository.receiveAllChatEvents(chats[i].id);
      chats[i] = chats[i].copyWith(
        newEvents: events,
      );
    }
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }

  Future<void> updateChats(Chat newChat) async {
    final index = state._chats.indexWhere((Chat chat) => chat.id == newChat.id);

    if (index != -1) {
      await state.chatsRepository.updateChat(newChat);
      final chats = await state.chatsRepository.receiveAllChats();
      for (var i = 0; i < chats.length; i++) {
        final events =
            await state.eventsRepository.receiveAllChatEvents(chats[i].id);
        chats[i] = chats[i].copyWith(
          newEvents: events,
        );
      }
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    } else {
      await state.chatsRepository.insertChat(newChat);
      final chats = await state.chatsRepository.receiveAllChats();
      for (var i = 0; i < chats.length; i++) {
        final events =
            await state.eventsRepository.receiveAllChatEvents(chats[i].id);
        chats[i] = chats[i].copyWith(
          newEvents: events,
        );
      }
      emit(
        state.copyWith(
          newChats: chats,
        ),
      );
    }
  }

  Future<void> deleteChat(String chatId) async {
    await state.chatsRepository.deleteChatById(chatId);
    var chats = await state.chatsRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }

  Future<void> togglePinState(String chatId) async {
    final chat = state._chats.where((Chat chat) => chat.id == chatId).first;

    await state.chatsRepository.updateChat(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
    var chats = await state.chatsRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }
}
