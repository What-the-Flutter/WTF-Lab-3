import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/chat.dart';
import '../../../data/repository/chats_repository.dart';
import '../../../data/repository/events_repository.dart';
import '../../data/models/event.dart';
import '../presentation.dart';

part 'home_state.dart';

typedef ChatsSubscription = StreamSubscription<List<Chat>>;

class HomeCubit extends Cubit<HomeState> {
  StreamSubscription<List<Chat>>? _chatsSubscription;

  final ChatsRepository chatsRepository;
  final EventsRepository eventsRepository;

  final SettingsCubit settingsCubit;

  HomeCubit({
    required this.chatsRepository,
    required this.eventsRepository,
    required this.settingsCubit,
  }) : super(const HomeState());

  void subscribeChatsStream() {
    _chatsSubscription =
        chatsRepository.chatsStream.listen(_setChats);
  }

  void unsubscribeChatsStream() {
    _chatsSubscription?.cancel(); 
  }

  void addChat(Chat chat) async {
    await chatsRepository.addChat(chat);
  }

  void deleteChat(String chatId) async {
    await chatsRepository.deleteChat(chatId);
    await eventsRepository.deleteEventsFromChat(chatId);
  }

  void editChat(Chat chat) async {
    await chatsRepository.updateChat(chat);
  }

  void switchChatPinning(Chat chat) async {
    await chatsRepository
        .updateChat(chat.copyWith(isPinned: !chat.isPinned));
  }

  void changeSelectedTab(int tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  void switchThemeType() => settingsCubit.switchThemeType();

  void initSettings() => settingsCubit.initSettings();

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
