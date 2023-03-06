import '../../../data/repos/event_repository.dart';
import '../../../domain/entities/chat.dart';

class ChatState {
  final EventRepositoryImpl eventRepository = EventRepositoryImpl();
  final Chat? chat;
  final bool isLoaded;
  final bool? isFavorite;
  final bool? isSearched;

  ChatState({
    this.chat,
    this.isFavorite,
    this.isSearched,
    required this.isLoaded,
  });

  ChatState copyWith({
    Chat? chat,
    bool? isFavorite,
    bool? isSearched,
    bool? isLoaded,
  }) {
    return ChatState(
      isLoaded: isLoaded ?? this.isLoaded,
      chat: chat ?? this.chat,
      isFavorite: isFavorite ?? this.isFavorite,
      isSearched: isSearched ?? this.isSearched,
    );
  }
}
