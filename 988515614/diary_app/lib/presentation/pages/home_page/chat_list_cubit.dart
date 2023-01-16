import 'package:diary_app/data/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diary_app/domain/entities/chat.dart';
import 'package:diary_app/presentation/pages/home_page/chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListChanged> {
  final LocalRepository localRepository;
  ChatListCubit(this.localRepository) : super(ChatListChanged(const [])) {
    initialize();
  }

  void updateAndSort() {
    var chats = List<Chat>.from(state.chats);

    chats.sort(((a, b) {
      if (a.isPinned && !b.isPinned) {
        return -1;
      } else if (b.isPinned && !a.isPinned) {
        return 1;
      } else {
        return a.createdAt.compareTo(b.createdAt);
      }
    }));

    emit(state.copyWith(chats: chats));
  }

  List<Chat> getChats() {
    return state.chats;
  }

  Future<void> initialize() async {
    final chats = await localRepository.loadChats();
    emit(state.copyWith(chats: chats));
    updateAndSort();
  }

  Future<void> pinUnpinChat(int index) async {
    final id = state.chats[index].id;
    await localRepository.pinUnpinChat(id);

    if (state.chats[index].isPinned) {
      state.chats[index].isPinned = false;
      var lastPinnedIndex = state.chats.lastIndexWhere((element) => element.isPinned);
      final chat = state.chats.removeAt(index);
      if (lastPinnedIndex < 0) lastPinnedIndex = 0;
      state.chats.insert(lastPinnedIndex, chat);
      updateAndSort();

      return;
    }

    final lastPinnedIndex = state.chats.lastIndexWhere((element) => element.isPinned);
    final chat = state.chats.removeAt(index);
    chat.isPinned = true;
    state.chats.insert(lastPinnedIndex + 1, chat);
    updateAndSort();
  }

  Future<void> editChat(Chat? result, int index) async {
    if (result != null) {
      final id = state.chats[index].id;
      await localRepository.editChat(id, result);

      state.chats[index].icon = result.icon;
      state.chats[index].title = result.title;
      updateAndSort();
    }
  }

  Future<void> removeChat(int index) async {
    final id = state.chats[index].id;
    await localRepository.removeChat(id);

    await localRepository.clearChatData(id);
    state.chats.removeAt(index);
    updateAndSort();
  }

  Future<void> addChat(Chat? result) async {
    if (result != null) {
      final id = await localRepository.addChat(result);

      final chatWithId = result;
      chatWithId.id = id;

      final lastPinnedIndex = state.chats.lastIndexWhere((element) => element.isPinned);
      state.chats.insert(lastPinnedIndex + 1, chatWithId);
      updateAndSort();
    }
  }

  Chat getChatData(int index) {
    return state.chats[index];
  }
}
