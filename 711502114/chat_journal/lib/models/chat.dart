import 'package:equatable/equatable.dart';

import 'event.dart';

class Chat extends Equatable {
  final int id;
  final String title;
  final List<Event> events;
  final int iconNumber;
  final String creationTime;
  final bool isPin;
  final bool isArchive;

  Chat({
    required this.id,
    required this.title,
    required this.events,
    required this.iconNumber,
    required this.creationTime,
    this.isPin = false,
    this.isArchive = false,
  });

  Chat copyWith({
    int? id,
    String? title,
    int? iconNumber,
    bool? isPin,
    bool? isArchive,
  }) {
    return Chat(
      id: id ?? this.id,
      title: title ?? this.title,
      events: events,
      iconNumber: iconNumber ?? this.iconNumber,
      creationTime: creationTime,
      isPin: isPin ?? this.isPin,
      isArchive: isArchive ?? this.isArchive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        events,
        iconNumber,
        creationTime,
        isPin,
        isArchive,
      ];
}
