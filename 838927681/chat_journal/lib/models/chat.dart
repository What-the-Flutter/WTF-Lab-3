import '../models/event.dart';

class Chat {
  final int id;
  final String name;
  final int iconIndex;
  final List<Event> events;
  final DateTime creationDate;
  final DateTime lastDate;

  Chat({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.creationDate,
    this.events = const [],
  }) : lastDate = events.isEmpty ? creationDate : events.last.dateTime;

  Chat copyWith({
    String? name,
    int? iconIndex,
    List<Event>? events,
    DateTime? creationDate,
  }) {
    return Chat(
      id: id,
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      events: events ?? this.events,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
