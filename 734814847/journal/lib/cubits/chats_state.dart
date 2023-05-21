import '../models/chat.dart';

class ChatsState {
  final List<Chat> chats;

  ChatsState({required this.chats});

  ChatsState copyWith({List<Chat>? updated}) =>
      ChatsState(chats: updated ?? chats);
}
