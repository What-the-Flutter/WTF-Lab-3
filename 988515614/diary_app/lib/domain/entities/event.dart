// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diary_app/domain/entities/event_category.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  // Persistent props
  int id;
  final int chatId;
  final bool isMessage;
  final DateTime dateTime;
  final String message;
  final String? image;
  EventCategory? category;
  bool isFavorite = false;

  // Temporary props
  bool isSelected = false;
  bool isDisplayed = true;

  Event({
    required this.id,
    required this.chatId,
    required this.isMessage,
    required this.dateTime,
    required this.message,
    this.category,
    this.image,
  });

  @override
  List<Object?> get props => [isSelected, isDisplayed, message];
}
