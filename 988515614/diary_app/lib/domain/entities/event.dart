// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Event {
  bool isFavorite = false;
  bool isSelected = false;
  final bool isMessage;
  final DateTime dateTime;
  final String message;
  final Image? image;

  Event({
    required this.isMessage,
    required this.dateTime,
    required this.message,
    this.image,
  });
}
