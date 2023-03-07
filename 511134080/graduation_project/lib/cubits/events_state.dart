part of 'events_cubit.dart';

class EventsState {
  final List<ChatModel> chats;

  EventsState({required this.chats});

  ChatModel getChatById(chatId) {
    print('getChat');
    return chats[chats.indexWhere((element) => element.id == chatId)];
  }

  EventCardModel getLastEvent(chatId) => getChatById(chatId).cards.last;

  EventsState copyWith(List<ChatModel>? newChats) {
    return EventsState(chats: newChats ?? chats);
  }
}
