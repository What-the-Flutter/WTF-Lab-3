import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';
import '../../../data/repository/events_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatsRepository _chatsRepository;
  final EventsRepository _eventsRepository;

  HomeCubit({required User? user})
      : _chatsRepository = ChatsRepository(user: user),
        _eventsRepository = EventsRepository(user: user),
        super(const HomeState());

  void initStream() {
    if (state.streamStatus.isInitial) {
      emit(
        state.copyWith(
          chatsStream: _chatsRepository.stream,
          streamStatus: StreamStatus.success,
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

  void sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }
}
