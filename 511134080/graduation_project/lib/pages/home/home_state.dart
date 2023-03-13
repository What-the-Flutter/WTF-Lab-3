part of 'home_cubit.dart';

class HomeState {
  final List<ChatModel> chats;

  HomeState({required this.chats});

  HomeState copyWith({List<ChatModel>? newChats}) =>
      HomeState(chats: newChats ?? chats);
}
