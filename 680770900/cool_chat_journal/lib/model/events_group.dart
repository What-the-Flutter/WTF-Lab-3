import 'event.dart';

/// Contains all events from group 
class EventsGroup {
  String groupName;
  final List<Event> events;

  bool get isEmpty => events.isEmpty;
  bool get isNotEmpty => events.isNotEmpty;
  int get count => events.length;

  EventsGroup(this.groupName, this.events);
  EventsGroup.empty(this.groupName): events = <Event>[];
}