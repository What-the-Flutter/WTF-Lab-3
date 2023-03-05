import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../chat/chat.dart' show Chat;

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(const ChatsState());

  void addNewChat(Chat chat) {
    final chats = List<Chat>.from(state.chats)..add(chat);
    final nextId = state.nextId + 1;
    _sortChats(chats);
    emit(state.copyWith(chats: chats, nextId: nextId));
  }

  void deleteChat(int chatId) {
    final chats = state.chats.where((chat) => chat.id != chatId).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void editChat(int id, Chat newChat) {
    final chats =
      state.chats.map((chat) => chat.id == id ? newChat : chat).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void switchChatPinning(int id) {
    final chats = state.chats
      .map((chat) =>
        chat.id == id ? chat.copyWith(isPinned: !chat.isPinned) : chat,
      ).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }
}
