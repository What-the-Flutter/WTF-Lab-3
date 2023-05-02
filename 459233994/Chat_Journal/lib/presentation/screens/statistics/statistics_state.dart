import '../../../domain/entities/event.dart';

class StatisticsState {
  final bool isLoaded;
  final List<Event>? events;

  StatisticsState({
    this.events,
    required this.isLoaded,
  });

  StatisticsState copyWith({
    bool? isLoaded,
    List<Event>? events,
  }) {
    return StatisticsState(
      isLoaded: isLoaded ?? this.isLoaded,
      events: events ?? this.events,
    );
  }
}
