import '../../models/event.dart';

class ChatState {
  final List<Event> events;
  final int favoritesCount;
  final bool isSelecting;
  final int selectedCount;
  final bool isEditing;
  final bool isTyping;
  final bool isFavoritesMode;
  final bool isSendingImage;
  final int selectedIndex;
  final bool isSelectedImage;

  ChatState({
    this.events = const [],
    this.favoritesCount = 0,
    this.isSelecting = false,
    this.selectedCount = 0,
    this.isEditing = false,
    this.isTyping = false,
    this.isFavoritesMode = false,
    this.isSendingImage = false,
    this.selectedIndex = 0,
    this.isSelectedImage = false,
  });

  ChatState copyWith({
    List<Event>? events,
    int? favoritesCount,
    bool? isSelecting,
    int? selectedCount,
    bool? isEditing,
    bool? isFavoritesMode,
    bool? isTyping,
    bool? isSendingImage,
    int? selectedIndex,
    bool? isSelectedImage,
  }) {
    return ChatState(
      events: events ?? this.events,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      isSelecting: isSelecting ?? this.isSelecting,
      selectedCount: selectedCount ?? this.selectedCount,
      isEditing: isEditing ?? this.isEditing,
      isFavoritesMode: isFavoritesMode ?? this.isFavoritesMode,
      isTyping: isTyping ?? this.isTyping,
      isSendingImage: isSendingImage ?? this.isSendingImage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isSelectedImage: isSelectedImage ?? this.isSelectedImage,
    );
  }
}
