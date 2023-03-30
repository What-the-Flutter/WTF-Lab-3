part of 'home_cubit.dart';

class HomeState {
  final List<Chat> chats;

  HomeState({
    this.chats = const [],
  });

  HomeState copyWith({
    List<Chat>? newChats,
  }) =>
      HomeState(
        chats: newChats ?? chats,
      );
}
