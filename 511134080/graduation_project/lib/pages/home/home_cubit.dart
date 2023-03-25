import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatRepository chatsRepository;
  final EventRepository eventsRepository;
  late final StreamSubscription<List<Chat>> chatsSubscription;

  HomeCubit({
    required this.chatsRepository,
    required this.eventsRepository,
  }) : super(HomeState());

  void init() {
    chatsSubscription = chatsRepository.chatsStream.listen((chats) async {
      /* for (var i = 0; i < chats.length; i++) {
        chats[i] = chats[i].copyWith(
            newEvents:
                await eventsRepository.receiveAllChatEvents(chats[i].id));
      }*/
      emit(state.copyWith(newChats: chats));
    });
  }

  Future<void> deleteChat(String chatId) async {
    await chatsRepository.deleteChatById(chatId);
  }

  Future<void> togglePinState(String chatId) async {
    final chat = state.chats.where((Chat chat) => chat.id == chatId).first;

    await chatsRepository.updateChat(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
  }
}
