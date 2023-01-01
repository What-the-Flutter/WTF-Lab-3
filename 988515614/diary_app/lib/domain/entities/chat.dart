// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Chat {
  IconData icon;
  String title;
  final DateTime createdAt;
  String? lastMessage;
  DateTime? updatedAt;
  bool isPinned = false;

  Chat({
    required this.icon,
    required this.title,
    required this.createdAt,
  });
}
