import '../../../domain/entities/chat.dart';

abstract class ChatState {}

class ChatNotLoaded extends ChatState {}

class ChatLoaded extends ChatState {
  final Chat chat;
  final bool isFavorite;

  ChatLoaded({required this.chat, required this.isFavorite});

  ChatLoaded copyWith({
    Chat? chat,
    bool? isFavorite,
  }) {
    return ChatLoaded(
      chat: chat ?? this.chat,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
