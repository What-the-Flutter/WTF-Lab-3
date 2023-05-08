import 'package:flutter/material.dart';

class Event {
  String text;
  final IconData? icon;
  final DateTime date;
  bool isSelected;
  bool selectionProcess;

  Event(
      {required this.text,
      required this.date,
      this.icon,
      this.isSelected = false,
      this.selectionProcess = false});
}
