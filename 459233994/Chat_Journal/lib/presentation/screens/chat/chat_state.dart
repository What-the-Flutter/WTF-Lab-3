import '../../../domain/entities/chat.dart';

class ChatState {
  final Chat? chat;
  final bool isLoaded;
  final bool? isFavorite;
  final bool? isSearched;
  final bool? isInputFilled;

  ChatState({
    this.chat,
    this.isFavorite,
    this.isSearched,
    this.isInputFilled,
    required this.isLoaded,
  });

  ChatState copyWith({
    Chat? chat,
    bool? isFavorite,
    bool? isSearched,
    bool? isLoaded,
    bool? isInputFilled,
  }) {
    return ChatState(
      isLoaded: isLoaded ?? this.isLoaded,
      chat: chat ?? this.chat,
      isFavorite: isFavorite ?? this.isFavorite,
      isSearched: isSearched ?? this.isSearched,
      isInputFilled: isInputFilled ?? this.isInputFilled,
    );
  }
}
