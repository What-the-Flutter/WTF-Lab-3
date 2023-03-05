import '../../../model/chat.dart';

class ChatsState {
  final int nextId;
  final List<Chat> chats;

  const ChatsState({
    this.nextId = 0,
    this.chats = const [],
  });

  ChatsState copyWith({
    int? nextId,
    List<Chat>? chats,
  }) => ChatsState(
    nextId: nextId ?? this.nextId,
    chats: chats ?? this.chats,
  );
}