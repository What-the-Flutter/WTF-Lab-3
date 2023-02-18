import '../../models/category.dart';
import '../../models/event.dart';

class EventState {
  final List<Event> events;
  final List<int> selectedItemIndexes;

  bool isFavoriteMode;
  bool isSelectedMode;
  bool isEditMode;
  bool isCategoryMode;

  Category? category;

  EventState({
    required this.events,
    required this.selectedItemIndexes,
    this.isFavoriteMode = false,
    this.isSelectedMode = false,
    this.isEditMode = false,
    this.isCategoryMode = false,
    this.category,
  });

  EventState copyWith({List<Event>? events}) {
    return EventState(
      events: events ?? this.events,
      selectedItemIndexes: selectedItemIndexes,
      isFavoriteMode: isFavoriteMode,
      isSelectedMode: isSelectedMode,
      isEditMode: isEditMode,
      isCategoryMode: isCategoryMode,
      category: category,
    );
  }
}
