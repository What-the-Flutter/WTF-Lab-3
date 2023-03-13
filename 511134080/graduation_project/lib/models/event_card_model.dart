import 'package:flutter/foundation.dart';

@immutable
class EventCardModel {
  final String title;
  final DateTime time;
  final bool isFavourite;
  final bool isSelected;
  final bool isSelectionMode;

  final int? categoryIndex;

  final dynamic id;

  const EventCardModel({
    required this.title,
    required this.time,
    required this.id,
    this.isFavourite = false,
    this.isSelected = false,
    this.isSelectionMode = false,
    this.categoryIndex,
  });

  EventCardModel copyWith({
    String? newTitle,
    DateTime? newTime,
    dynamic newId,
    bool? isFavourite,
    bool? isSelected,
    bool? isSelectionMode,
    int? newCategory,
  }) {
    return EventCardModel(
      title: newTitle ?? title,
      time: newTime ?? time,
      id: newId ?? id,
      isFavourite: isFavourite ?? this.isFavourite,
      isSelected: isSelected ?? this.isSelected,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      categoryIndex: newCategory ?? categoryIndex,
    );
  }
}
