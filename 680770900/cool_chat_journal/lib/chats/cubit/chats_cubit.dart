import 'package:bloc/bloc.dart';
import 'package:chats_repository/chats_repository.dart';
import 'package:equatable/equatable.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatsRepository _chatsRepository;

  ChatsCubit(this._chatsRepository) : super(const ChatsState());

  void updateChats() async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: ChatsStatus.loading));

      final chats = await _chatsRepository.loadChats();

      _sortChats(chats);

      emit(
        state.copyWith( 
          chats: chats,
          status: ChatsStatus.success,
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
    editChat(chat.copyWith(isPinned: !chat.isPinned));
  }

  void transferEvents({
    required String sourceChatId,
    required String destinationChatId,
    required List<String> transferEventsIds, 
  }) async {
    final sourceChat =
      state.chats.firstWhere((chat) => chat.id == sourceChatId);
    final destinationChat =
      state.chats.firstWhere((chat) => chat.id == destinationChatId);
    final transferEvents = 
      sourceChat.events.where((event) => transferEventsIds.contains(event.id));

    final newSourceChat = sourceChat.copyWith(
      events: sourceChat.events
        .where((event) => !transferEvents.contains(event))
        .toList(),
    ); 

    final newDestinationChat = destinationChat.copyWith(
      events: List<Event>.from(destinationChat.events)
        ..addAll(
          transferEvents.map(
            (event) => event.copyWith(chatId: destinationChatId),
          ),
        ),
    );

    editChat(newSourceChat);
    editChat(newDestinationChat);
  }

  void _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }
}
