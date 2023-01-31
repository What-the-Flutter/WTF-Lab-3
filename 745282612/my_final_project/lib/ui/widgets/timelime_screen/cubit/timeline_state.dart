import 'package:equatable/equatable.dart';

import 'package:my_final_project/entities/event.dart';

class TimelineState extends Equatable {
  final List<Event> filterList;
  final List<int> filterChat;
  final List<String> filterTags;
  final List<String> filterSection;
  final DateTime? filterDateTime;
  final bool isFavorite;
  final String searchText;
  final String onlyPicture;

  TimelineState({
    required this.filterList,
    required this.filterChat,
    required this.filterTags,
    required this.filterSection,
    required this.filterDateTime,
    this.onlyPicture = 'No',
    this.isFavorite = false,
    this.searchText = '',
  });

  TimelineState copyWith({
    List<Event>? filterList,
    List<int>? filterChat,
    List<String>? filterTags,
    List<String>? filterSection,
    DateTime? filterDateTime,
    bool? isFavorite,
    String? searchText,
    String? onlyPicture,
  }) {
    return TimelineState(
      filterTags: filterTags ?? this.filterTags,
      filterList: filterList ?? this.filterList,
      filterChat: filterChat ?? this.filterChat,
      filterSection: filterSection ?? this.filterSection,
      filterDateTime: filterDateTime,
      isFavorite: isFavorite ?? this.isFavorite,
      searchText: searchText ?? this.searchText,
      onlyPicture: onlyPicture ?? this.onlyPicture,
    );
  }

  @override
  List<Object?> get props => [
        onlyPicture,
        filterList,
        filterChat,
        filterTags,
        filterSection,
        filterDateTime,
        isFavorite,
        searchText,
      ];
}
