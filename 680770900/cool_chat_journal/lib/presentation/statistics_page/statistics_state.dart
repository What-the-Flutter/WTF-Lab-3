part of 'statistics_cubit.dart';

class StatisticsState extends Equatable {
  final DateFilter currentFilter;
  final List<Event> events;

  const StatisticsState({
    this.currentFilter = DateFilter.today,
    this.events = const [],
  });

  StatisticsState copyWith({
    DateFilter? currentFilter,
    List<Event>? events,
  }) =>
      StatisticsState(
        currentFilter: currentFilter ?? this.currentFilter,
        events: events ?? this.events,
      );

  @override
  List<Object> get props => [currentFilter, events];
}
