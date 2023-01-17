import 'event.dart';

class Chat {
  final String title;
  final List<Event> events;
  final String assetsLink;

  Chat({
    required this.title,
    required this.events,
    required this.assetsLink,
  });
}
