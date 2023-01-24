import '../../models/chat.dart';

class HomePageState {
  final List<Chat> chats;

  const HomePageState({required this.chats});

  HomePageState copyWith({List<Chat>? chats}) {
    return HomePageState(chats: chats ?? this.chats);
  }
}
