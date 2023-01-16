// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Chat extends Equatable {
  int id;
  final DateTime createdAt;
  IconData icon;
  String title;
  String? lastMessage;
  DateTime? updatedAt;
  bool isPinned = false;

  Chat({
    required this.id,
    required this.createdAt,
    required this.icon,
    required this.title,
    this.lastMessage,
    this.updatedAt,
    this.isPinned = false,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        icon,
        title,
        isPinned,
      ];
}
