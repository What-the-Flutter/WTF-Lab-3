import 'event.dart';

/// Contains all events from group 
class Chat {
  final String name;
  final List<Event> events;
  final DateTime createdTime;
  final DateTime? latestEventTime;

  Chat({
    required this.name,
    required this.events,
    required this.createdTime,
    this.latestEventTime,
  });

  Chat copyWith({
    String? name,
    List<Event>? events,
    DateTime? createdTime,
    DateTime? latestEventTime,
  }) {
    return Chat(
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
      latestEventTime: latestEventTime ?? this.latestEventTime,
    );
  }
}