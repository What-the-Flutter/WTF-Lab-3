import 'package:chats_repository/chats_repository.dart'
  as repository show Event;
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Category {
  movie,
  fastFood,
  workout,
  sports,
  laundry,
}

extension CategoryX on Category {
  String get title => name[0].toUpperCase() + name.substring(1);
  IconData get icon {
    switch (this) {
      case Category.movie:
        return Icons.theaters;
      case Category.fastFood:
        return Icons.fastfood;
      case Category.workout:
        return Icons.fitness_center;
      case Category.sports:
        return Icons.sports_basketball;
      case Category.laundry:
        return Icons.local_laundry_service;
    }
  }
}

class Event extends Equatable {
  final int id;
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;
  final Category? category;

  const Event({
    this.id = 0,
    required this.content,
    required this.changeTime,
    this.isFavorite = false,
    this.isImage = false,
    this.category,
  });

  factory Event.fromRepositoryEvent(repository.Event event) =>
    Event(
      id: event.id,
      content: event.content,
      isImage: event.isImage,
      isFavorite: event.isFavorite,
      changeTime: event.changeTime,
      category: Category.values.firstWhereOrNull(
        (e) => e.name == event.category,
      ),
    );

  repository.Event toRepositoryEvent() =>
    repository.Event(
      id: id,
      content: content,
      isImage: isImage,
      isFavorite: isFavorite,
      changeTime: changeTime,
      category: category?.name,
    );

  Event copyWith({
    int? id,
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
    Category? category,
  }) {
    return Event(
      id: id ?? this.id,
      content: content ?? this.content,
      isImage: isImage ?? this.isImage,
      isFavorite: isFavorite ?? this.isFavorite,
      changeTime: changeTime ?? this.changeTime,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props =>
    [id, content, isImage, isFavorite, changeTime, category];
}
