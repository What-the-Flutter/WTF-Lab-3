import 'event.dart';

class Chat {
  final String title;
  final List<Event> events;
  final String assetsLink;

  String _description = '';

  Chat({
    required this.title,
    required this.events,
    required this.assetsLink,
  }) {
    if (events.isNotEmpty) {
      final event = events[events.length - 1];
      _description = event.message;
    }
  }

  bool get isDescriptionEmpty => _description.isEmpty;

  String get description => _description;
}
