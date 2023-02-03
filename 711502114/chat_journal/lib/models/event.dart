import 'package:equatable/equatable.dart';

import 'category.dart';

class Event extends Equatable {
  final String message;
  final DateTime dateTime;
  final bool isFavorite;
  final bool isSelected;
  final String? photoPath;
  final Category? category;

  Event({
    required this.message,
    required this.dateTime,
    this.isFavorite = false,
    this.isSelected = false,
    this.photoPath,
    this.category,
  });

  Event copyWith({
    String? message,
    DateTime? dateTime,
    bool? isFavorite,
    bool? isSelected,
    String? photoPath,
    Category? category,
  }) {
    return Event(
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      isFavorite: isFavorite ?? this.isFavorite,
      isSelected: isSelected ?? this.isSelected,
      photoPath: photoPath ?? this.photoPath,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        message,
        dateTime,
        isFavorite,
        isSelected,
        photoPath,
        category,
      ];
}
