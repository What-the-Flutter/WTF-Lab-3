import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';
import '../../../data/repository/events_repository.dart';

part 'home_state.dart';

typedef ChatsSubscription = StreamSubscription<List<Chat>>;

class HomeCubit extends Cubit<HomeState> {
  final ChatsRepository _chatsRepository;
  final EventsRepository _eventsRepository;

  HomeCubit({required User? user})
      : _chatsRepository = ChatsRepository(user: user),
        _eventsRepository = EventsRepository(user: user),
        super(const HomeState());

  void subscribeChatsStream() {
    final subscription = _chatsRepository.chatsStream.listen(_setChats);

    emit(
      state.copyWith(
        streamSubscription: _NullWrapper<ChatsSubscription?>(subscription),
      ),
    );
  }

  void unsubscribeChatsStream() {
    if (state.streamSubscription != null) {
      state.streamSubscription!.cancel();

      emit(
        state.copyWith(
          streamSubscription: const _NullWrapper<ChatsSubscription?>(null),
        ),
      );
    }
  }

  void addChat(Chat chat) async {
    await _chatsRepository.addChat(chat);
  }

  void deleteChat(String chatId) async {
    await _chatsRepository.deleteChat(chatId);
    await _eventsRepository.deleteEventsFromChat(chatId);
  }

  void editChat(Chat chat) async {
    await _chatsRepository.updateChat(chat);
  }

  void switchChatPinning(Chat chat) async {
    await _chatsRepository.updateChat(chat.copyWith(isPinned: !chat.isPinned));
  }

  void _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }

  void _setChats(List<Chat> chats) {
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }
}
