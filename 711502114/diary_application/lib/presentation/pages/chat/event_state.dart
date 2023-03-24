import 'package:diary_application/domain/models/category.dart';
import 'package:diary_application/domain/models/event.dart';

class EventState {
  final String chatId;
  final List<Event> events;
  final List<int> selectedIndexes;

  bool isFavoriteMode;
  bool isSelectedMode;
  bool isEditMode;
  bool isCategoryMode;

  Category? category;

  EventState({
    required this.chatId,
    required this.events,
    required this.selectedIndexes,
    this.isFavoriteMode = false,
    this.isSelectedMode = false,
    this.isEditMode = false,
    this.isCategoryMode = false,
    this.category,
  });

  EventState copyWith({String? chatId, List<Event>? events}) {
    return EventState(
      chatId: chatId ?? this.chatId,
      events: events ?? this.events,
      selectedIndexes: selectedIndexes,
      isFavoriteMode: isFavoriteMode,
      isSelectedMode: isSelectedMode,
      isEditMode: isEditMode,
      isCategoryMode: isCategoryMode,
      category: category,
    );
  }
}
