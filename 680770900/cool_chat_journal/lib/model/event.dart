import 'category.dart';

/// Contains information about event.
class Event {
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

  Event copyWith({
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
    Category? category,
  }) {
    return Event(
      content: content ?? this.content,
      isImage: isImage ?? this.isImage,
      isFavorite: isFavorite ?? this.isFavorite,
      changeTime: changeTime ?? this.changeTime,
      category: category ?? this.category,
    );
  }
}
