import '../../models/category.dart';
import '../../models/event.dart';

class EventState {
  final int id;
  final int chatId;
  final List<Event> events;
  final List<int> selectedIndexes;

  bool isFavoriteMode;
  bool isSelectedMode;
  bool isEditMode;
  bool isCategoryMode;

  Category? category;

  EventState({
    required this.id,
    required this.chatId,
    required this.events,
    required this.selectedIndexes,
    this.isFavoriteMode = false,
    this.isSelectedMode = false,
    this.isEditMode = false,
    this.isCategoryMode = false,
    this.category,
  });

  EventState copyWith({int? id, int? chatId, List<Event>? events}) {
    return EventState(
      id: id ?? this.id,
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
