import 'package:flutter/material.dart';
import './message_event.dart';

class EventsTab {
  String name;
  Icon icon;
  List<MessageEvent> events = [];

  EventsTab({required this.name, required this.icon});

  String recentRecord() {
    return events.isEmpty ? 'No events. Click to create one' : events.last.text;
  }
}
