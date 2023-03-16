part of 'home_cubit.dart';

class HomeState {
  final List<Chat> _chats;
  final chatsRepository = ChatRepository();
  final eventsRepository = EventRepository();

  HomeState({List<Chat> chats = const []}) : _chats = chats;

  List<Chat> get chats => _chats;

  HomeState copyWith({List<Chat>? newChats}) =>
      HomeState(chats: newChats ?? _chats);
}
