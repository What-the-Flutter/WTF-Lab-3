import '../models/event.dart';

class Chat {
  final String name;
  final int iconIndex;
  final List<Event> events;
  final DateTime creationDate;

  Chat({
    required this.name,
    required this.iconIndex,
    required this.creationDate,
    this.events = const [],
  });

  Chat copyWith({
    String? name,
    int? iconIndex,
    List<Event>? events,
    DateTime? creationDate,
    int? favoritesCount,
  }) {
    return Chat(
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      events: events ?? this.events,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
