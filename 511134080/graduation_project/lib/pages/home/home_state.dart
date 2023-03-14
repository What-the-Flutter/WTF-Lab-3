part of 'home_cubit.dart';

class HomeState {
  final List<ChatModel> _chats;

  HomeState({required List<ChatModel> chats}) : _chats = chats;

  List<ChatModel> get chats => _chats;

  HomeState copyWith({List<ChatModel>? newChats}) =>
      HomeState(chats: newChats ?? _chats);
}
