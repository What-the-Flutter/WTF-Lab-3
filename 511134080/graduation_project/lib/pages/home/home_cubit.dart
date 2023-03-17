import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepository chatsRepository;
  final EventRepository eventsRepository;

  HomeCubit({
    required this.chatsRepository,
    required this.eventsRepository,
  }) : super(HomeState()) {
    loadChats();
  }

  Future<void> loadChats() async {
    final chats = await chatsRepository.receiveAllChats();
    for (var i = 0; i < chats.length; i++) {
      final events = await eventsRepository.receiveAllChatEvents(chats[i].id);
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
    final index = state.chats.indexWhere((Chat chat) => chat.id == newChat.id);

    if (index != -1) {
      await chatsRepository.updateChat(newChat);
      final chats = await chatsRepository.receiveAllChats();
      for (var i = 0; i < chats.length; i++) {
        final events = await eventsRepository.receiveAllChatEvents(chats[i].id);
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
      await chatsRepository.insertChat(newChat);
      final chats = await chatsRepository.receiveAllChats();
      for (var i = 0; i < chats.length; i++) {
        final events = await eventsRepository.receiveAllChatEvents(chats[i].id);
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
    await chatsRepository.deleteChatById(chatId);
    var chats = await chatsRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }

  Future<void> togglePinState(String chatId) async {
    final chat = state.chats.where((Chat chat) => chat.id == chatId).first;

    await chatsRepository.updateChat(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
    var chats = await chatsRepository.receiveAllChats();
    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }
}
