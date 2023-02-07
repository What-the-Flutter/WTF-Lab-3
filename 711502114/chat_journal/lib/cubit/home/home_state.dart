import '../../models/chat.dart';

class HomeState {
  final List<Chat> chats;

  HomeState({required this.chats});

  HomeState copyWith({List<Chat>? chats}) {
    return HomeState(chats: chats ?? this.chats);
  }
}
