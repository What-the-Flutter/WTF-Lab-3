import 'package:equatable/equatable.dart';
import 'package:my_final_project/entities/event.dart';

class TimelineState extends Equatable {
  final List<Event> filterList;
  final List<int> filterChat;
  final List<String> filterTags;
  final List<String> filterSection;
  final DateTime? filterDateTime;

  TimelineState({
    required this.filterList,
    required this.filterChat,
    required this.filterTags,
    required this.filterSection,
    required this.filterDateTime,
  });

  TimelineState copyWith({
    List<Event>? filterList,
    List<int>? filterChat,
    List<String>? filterTags,
    List<String>? filterSection,
    DateTime? filterDateTime,
  }) {
    return TimelineState(
      filterTags: filterTags ?? this.filterTags,
      filterList: filterList ?? this.filterList,
      filterChat: filterChat ?? this.filterChat,
      filterSection: filterSection ?? this.filterSection,
      filterDateTime: filterDateTime,
    );
  }

  @override
  List<Object?> get props => [
        filterList,
        filterChat,
        filterTags,
        filterSection,
        filterDateTime,
      ];
}
