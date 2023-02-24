import '../models/events_tab.dart';

class EventsTabsProvider {
  static EventsTabsProvider? _instance;
  List<EventsTab> tabs = [];

  EventsTabsProvider._internal() {
    _instance = this;
  }

  factory EventsTabsProvider() => _instance ?? EventsTabsProvider._internal();
}
