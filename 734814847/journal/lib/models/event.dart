import 'package:flutter/material.dart';

class Event {
  String text;
  DateTime date;
  bool isSelected;
  bool isSelectionProcess;
  Key key;

  Event(
      {required this.text,
      required this.date,
      required this.key,
      this.isSelected = false,
      this.isSelectionProcess = false});
}
