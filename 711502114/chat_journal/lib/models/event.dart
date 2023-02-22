import 'package:equatable/equatable.dart';

import 'category.dart';

class Event extends Equatable {
  final int id;
  final int chatId;
  final String message;
  final String creationTime;
  final bool isFavorite;
  final bool isSelected;
  final String? photoPath;
  final Category? category;

  Event({
    required this.id,
    required this.chatId,
    required this.message,
    required this.creationTime,
    this.isFavorite = false,
    this.isSelected = false,
    this.photoPath,
    this.category,
  });

  Event copyWith({
    int? id,
    int? chatId,
    String? message,
    String? creationTime,
    bool? isFavorite,
    bool? isSelected,
    String? photoPath,
    Category? category,
  }) {
    return Event(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      message: message ?? this.message,
      creationTime: creationTime ?? this.creationTime,
      isFavorite: isFavorite ?? this.isFavorite,
      isSelected: isSelected ?? this.isSelected,
      photoPath: photoPath ?? this.photoPath,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        message,
        creationTime,
        isFavorite,
        isSelected,
        photoPath,
        category,
      ];
}
