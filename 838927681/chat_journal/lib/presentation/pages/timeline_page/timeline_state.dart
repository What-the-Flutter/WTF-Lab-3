import 'package:equatable/equatable.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/tag.dart';

class TimelineState extends Equatable {
  final List<Event> events;
  final List<Event> favorites;
  final List<Tag> tags;
  final bool isSelectingState;
  final bool isEditingState;
  final bool isFavoritesMode;
  final int selectedIndex;
  final int selectedCount;
  final int selectedRadioIndex;

  const TimelineState({
    required this.events,
    required this.isEditingState,
    required this.isSelectingState,
    required this.favorites,
    required this.isFavoritesMode,
    required this.selectedIndex,
    required this.selectedCount,
    required this.tags,
    required this.selectedRadioIndex,
  });

  TimelineState copyWith({
    List<Event>? events,
    List<Event>? favorites,
    bool? isSelectingState,
    bool? isEditingState,
    bool? isFavoritesMode,
    int? selectedIndex,
    int? selectedCount,
    List<Tag>? tags,
    int? selectedRadioIndex,
  }) {
    return TimelineState(
      events: events ?? this.events,
      isEditingState: isEditingState ?? this.isEditingState,
      isSelectingState: isSelectingState ?? this.isSelectingState,
      favorites: favorites ?? this.favorites,
      isFavoritesMode: isFavoritesMode ?? this.isFavoritesMode,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedCount: selectedCount ?? this.selectedCount,
      tags: tags ?? this.tags,
      selectedRadioIndex: selectedRadioIndex ?? this.selectedRadioIndex,
    );
  }

  @override
  List<Object?> get props => [
        events,
        isSelectingState,
        isEditingState,
        favorites,
        isFavoritesMode,
        selectedIndex,
        selectedCount,
        selectedRadioIndex,
        tags,
      ];
}
