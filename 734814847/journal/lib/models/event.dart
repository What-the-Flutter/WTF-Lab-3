import 'package:flutter/material.dart';

class Event {
  String text;
  final IconData? icon;
  final DateTime date;

  Event({required this.text, required this.date, this.icon});
}
