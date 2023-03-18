import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _chatsRepository = ChatsRepository();

  HomeCubit() : super(const HomeState());

  void updateChats() async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: HomeStatus.loading));

      final chats = await _chatsRepository.loadChats();
      _sortChats(chats);

      emit(
        state.copyWith(
          chats: chats,
          status: HomeStatus.success,
        ),
      );
    }
  }

  void addChat(Chat chat) async {
    await _chatsRepository.addChat(chat);
    updateChats();
  }

  void deleteChat(String chatId) async {
    await _chatsRepository.deleteChat(chatId);
    updateChats();
  }

  void editChat(Chat chat) async {
    await _chatsRepository.updateChat(chat);
    updateChats();
  }

  void switchChatPinning(String id) async {
    final chat = state.chats.firstWhere((chat) => chat.id == id);
    editChat(
      chat.copyWith(isPinned: !chat.isPinned),
    );
  }

  void _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }
}
