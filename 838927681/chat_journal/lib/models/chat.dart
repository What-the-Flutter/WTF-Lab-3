import 'package:flutter/material.dart';

import '../models/event.dart';

class Chat {
  final String name;
  final IconData icon;
  final List<Event> events;
  int favoritesCount = 0;

  Chat({required this.name, required this.icon, this.events = const []});
}
