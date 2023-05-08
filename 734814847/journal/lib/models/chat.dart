import 'package:flutter/material.dart';

import '../models/event.dart';

class Chat {
  Key key;
  String name;
  Icon icon;
  List<Event> events = <Event>[];
  List<Event> selectedEvents = <Event>[];

  Chat({required this.name, required this.icon, required this.key});
}
