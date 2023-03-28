import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';
import '../../../data/repository/events_repository.dart';

part 'home_state.dart';

typedef ChatsSubscription = StreamSubscription<List<Chat>>;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void subscribeChatsStream() {
    final subscription =
        GetIt.I<ChatsRepository>().chatsStream.listen(_setChats);

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
    await GetIt.I<ChatsRepository>().addChat(chat);
  }

  void deleteChat(String chatId) async {
    await GetIt.I<ChatsRepository>().deleteChat(chatId);
    await GetIt.I<EventsRepository>().deleteEventsFromChat(chatId);
  }

  void editChat(Chat chat) async {
    await GetIt.I<ChatsRepository>().updateChat(chat);
  }

  void switchChatPinning(Chat chat) async {
    await GetIt.I<ChatsRepository>()
        .updateChat(chat.copyWith(isPinned: !chat.isPinned));
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
