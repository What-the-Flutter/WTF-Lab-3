import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

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
  }) : super(HomeState()) {
    init();
  }

  void init() {
    chatsSubscription = chatsRepository.chatsStream.listen((chats) async {
      emit(state.copyWith(newChats: chats));
    });
  }

  Future<void> deleteChat(String chatId) async =>
      await chatsRepository.deleteChatById(chatId);

  Future<void> togglePinState(String chatId) async {
    final chat = state.chats.where((Chat chat) => chat.id == chatId).first;

    await chatsRepository.updateChat(
      chat.copyWith(
        pinned: !chat.isPinned,
      ),
    );
  }

  Future<void> share() async =>
      await Share.share('Keep track of your life with Chat Journal, '
          'a simple and elegant chat-based journal/notes'
          ' application that makes journaling/note-taking fun, '
          'easy, quick and effortless.\nhttps://play.google.com/'
          'store/apps/details?id=com.agiletelescope.chatjournal');
}
