import '../../../model/chat.dart';
import '../../../model/event.dart';

class ChatState {
  final Chat? chat;
  final bool isEditMode;
  final bool isFavoriteMode;
  final List<int> selectedEvents;

  const ChatState({
    this.chat,
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.selectedEvents = const [],
  });

  ChatState copyWith({
    Chat? chat,
    bool? isEditMode,
    bool? isFavoriteMode,
    List<int>? selectedEvents,
  }) => ChatState(
    chat: chat ?? this.chat,
    isEditMode: isEditMode ?? this.isEditMode,
    isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
    selectedEvents: selectedEvents ?? this.selectedEvents,
  );
}