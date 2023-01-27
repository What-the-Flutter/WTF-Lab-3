import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String message;
  final DateTime dateTime;
  final bool isFavorite;
  final bool isSelected;
  final String? photoPath;

  Event({
    required this.message,
    required this.dateTime,
    this.isFavorite = false,
    this.isSelected = false,
    this.photoPath,
  });

  Event copyWith({
    String? message,
    DateTime? dateTime,
    bool? isFavorite,
    bool? isSelected,
    String? photoPath,
  }) {
    return Event(
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      isFavorite: isFavorite ?? this.isFavorite,
      isSelected: isSelected ?? this.isSelected,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  List<Object?> get props => [
        message,
        dateTime,
        isFavorite,
        isSelected,
        photoPath,
      ];
}
