import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';
import '../../../data/repository/events_repository.dart';

part 'home_state.dart';

typedef ChatsSubscription = StreamSubscription<List<Chat>>;

class HomeCubit extends Cubit<HomeState> {
  final ChatsRepository _chatsRepository;
  final EventsRepository _eventsRepository;
  
  late final StreamSubscription<List<Chat>> _chatsSubscription;

  HomeCubit(
    this._chatsRepository,
    this._eventsRepository,
  ) : super(const HomeState()) {
    _chatsSubscription = _chatsRepository.chatsStream.listen(_setChats);
  }

  @override
  Future<void> close() {
    _chatsSubscription.cancel();
    return super.close();
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
