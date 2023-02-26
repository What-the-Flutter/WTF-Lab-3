import 'package:equatable/equatable.dart';

import '../../../domain/entities/event.dart';

class ChatState extends Equatable {
  final List<Event> events;
  final List<Event> favorites;
  final bool isSelecting;
  final int selectedCount;
  final bool isEditing;
  final bool isTyping;
  final bool isFavoritesMode;
  final bool isSendingImage;
  final int selectedIndex;
  final bool isSelectedImage;
  final bool isSelectingCategory;
  final int selectedIcon;
  final int? selectedRadioIndex;
  final int counterId;
  final String chatId;

  ChatState({
    this.events = const [],
    this.favorites = const [],
    this.isSelecting = false,
    this.selectedCount = 0,
    this.isEditing = false,
    this.isTyping = false,
    this.isFavoritesMode = false,
    this.isSendingImage = false,
    this.selectedIndex = 0,
    this.isSelectedImage = false,
    this.isSelectingCategory = false,
    this.selectedIcon = 0,
    this.selectedRadioIndex = 0,
    this.counterId = 0,
    this.chatId = '',
  });

  ChatState copyWith(
      {List<Event>? events,
      List<Event>? favorites,
      bool? isSelecting,
      int? selectedCount,
      bool? isEditing,
      bool? isFavoritesMode,
      bool? isTyping,
      bool? isSendingImage,
      int? selectedIndex,
      bool? isSelectedImage,
      bool? isSelectingCategory,
      int? selectedIcon,
      int? selectedRadioIndex,
      int? counterId,
      String? chatId}) {
    return ChatState(
      events: events ?? this.events,
      favorites: favorites ?? this.favorites,
      isSelecting: isSelecting ?? this.isSelecting,
      selectedCount: selectedCount ?? this.selectedCount,
      isEditing: isEditing ?? this.isEditing,
      isFavoritesMode: isFavoritesMode ?? this.isFavoritesMode,
      isTyping: isTyping ?? this.isTyping,
      isSendingImage: isSendingImage ?? this.isSendingImage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isSelectedImage: isSelectedImage ?? this.isSelectedImage,
      isSelectingCategory: isSelectingCategory ?? this.isSelectingCategory,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      selectedRadioIndex: selectedRadioIndex ?? this.selectedRadioIndex,
      counterId: counterId ?? this.counterId,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  List<Object?> get props => [
        events,
        favorites,
        isSelecting,
        selectedCount,
        isEditing,
        isFavoritesMode,
        isTyping,
        isSendingImage,
        selectedIndex,
        isSelectedImage,
        isSelectingCategory,
        selectedIcon,
        selectedRadioIndex,
        chatId
      ];
}
