import '../../../domain/entities/chat.dart';
import '../../../domain/entities/tag.dart';

class ChatState {
  final Chat? chat;
  final List<Tag>? tags;
  final bool isLoaded;
  final bool? isFavorite;
  final bool? isSearched;
  final bool? isInputFilled;
  final bool? isFilledTag;

  ChatState({
    this.chat,
    this.tags,
    this.isFavorite,
    this.isSearched,
    this.isInputFilled,
    this.isFilledTag,
    required this.isLoaded,
  });

  ChatState copyWith({
    Chat? chat,
    List<Tag>? tags,
    bool? isFavorite,
    bool? isSearched,
    bool? isLoaded,
    bool? isInputFilled,
    bool? isFilledTag,
  }) {
    return ChatState(
      isLoaded: isLoaded ?? this.isLoaded,
      chat: chat ?? this.chat,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      isSearched: isSearched ?? this.isSearched,
      isInputFilled: isInputFilled ?? this.isInputFilled,
      isFilledTag: isFilledTag ?? this.isFilledTag,
    );
  }
}
