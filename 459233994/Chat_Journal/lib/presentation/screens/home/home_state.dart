import '../../../domain/entities/chat.dart';

class HomeState {
  final List<Chat> chats;

  HomeState({chats}) : chats = chats ?? [];
}
