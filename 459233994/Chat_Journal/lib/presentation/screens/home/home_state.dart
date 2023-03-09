import '../../../data/repos/chat_repository.dart';
import '../../../domain/entities/chat.dart';

class HomeState {
  final ChatRepositoryImpl chatRepository = ChatRepositoryImpl();
  final List<Chat> chats;

  HomeState({chats}) : chats = chats ?? [];
}
