import '../../../domain/entities/event.dart';

class TimeLineState {
  final List<Event>? events;
  final bool isLoaded;
  final bool? isFavorite;
  final bool? isSearched;

  TimeLineState({
    this.events,
    this.isSearched,
    this.isFavorite,
    required this.isLoaded,
  });

  TimeLineState copyWith({
    List<Event>? events,
    bool? isFavorite,
    bool? isSearched,
    bool? isLoaded,
  }) {
    return TimeLineState(
      isLoaded: isLoaded ?? this.isLoaded,
      isFavorite: isFavorite ?? this.isFavorite,
      isSearched: isSearched ?? this.isSearched,
      events: events ?? this.events,
    );
  }
}
