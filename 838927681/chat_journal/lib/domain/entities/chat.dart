import 'event.dart';

class Chat {
  final int id;
  final String name;
  final int iconIndex;
  final DateTime creationDate;
  final List<Event> events;

  Chat({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.creationDate,
    this.events = const [],
  });

  DateTime get lastDate =>
      events.isNotEmpty ? events.last.dateTime : creationDate;

  Chat copyWith({
    int? id,
    String? name,
    int? iconIndex,
    DateTime? creationDate,
    List<Event>? events,
  }) {
    return Chat(
      id: id ?? this.id,
      events: events ?? this.events,
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
