part of 'home_cubit.dart';

class HomeState {
  final List<Chat> _chats;

  HomeState({required List<Chat> chats}) : _chats = chats;

  List<Chat> get chats => _chats;

  HomeState copyWith({List<Chat>? newChats}) =>
      HomeState(chats: newChats ?? _chats);
}
