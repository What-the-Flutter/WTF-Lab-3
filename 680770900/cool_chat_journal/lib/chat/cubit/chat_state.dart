part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final Chat chat;
  final bool isEditMode;
  final bool isFavoriteMode;
  final List<int> selectedEventsIds;

  ChatState({
    required this.chat,
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.selectedEventsIds = const [],
  });

  ChatState copyWith({
    Chat? chat,
    bool? isEditMode,
    bool? isFavoriteMode,
    List<int>? selectedEventsIds,
  }) => ChatState(
    chat: chat ?? this.chat,
    isEditMode: isEditMode ?? this.isEditMode,
    isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
    selectedEventsIds: selectedEventsIds ?? this.selectedEventsIds,
  );

  @override
  List<Object> get props =>
    [chat, isEditMode, isFavoriteMode, selectedEventsIds];
}
