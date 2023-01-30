import '../../models/event.dart';

class EventState {
  final List<Event> events;

  EventState({required this.events});

  EventState copyWith({List<Event>? events}) {
    return EventState(events: events ?? this.events);
  }
}
