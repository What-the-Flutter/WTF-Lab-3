import 'package:diary_application/domain/models/category.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/models/tag.dart';

class EventState {
  final String chatId;
  final List<Event> events;
  final List<int> selectedIndexes;
  final List<Tag> tags;

  bool isFavoriteMode;
  bool isSelectedMode;
  bool isEditMode;
  bool isCategoryMode;
  bool isHashTag;

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
    this.tags = const [],
    this.isHashTag = false,
  });

  EventState copyWith({
    String? chatId,
    List<Event>? events,
    List<Tag>? tags,
    bool? isHashTag,
  }) {
    return EventState(
      chatId: chatId ?? this.chatId,
      events: events ?? this.events,
      selectedIndexes: selectedIndexes,
      isFavoriteMode: isFavoriteMode,
      isSelectedMode: isSelectedMode,
      isEditMode: isEditMode,
      isCategoryMode: isCategoryMode,
      category: category,
      tags: tags ?? this.tags,
      isHashTag: isHashTag ?? this.isHashTag,
    );
  }
}
