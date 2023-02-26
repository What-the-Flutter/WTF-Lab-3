import 'chat.dart';

class ChatsState {
  final List<Chat> chats;
  final Map<int, bool> pinnedChats;

  const ChatsState({
    this.chats = const [],
    this.pinnedChats = const {},
  });

  ChatsState copyWith({
    List<Chat>? chats,
    Map<int, bool>? pinnedChats,
  }) => ChatsState(
    chats: chats ?? this.chats,
    pinnedChats: pinnedChats ?? this.pinnedChats,
  );
}