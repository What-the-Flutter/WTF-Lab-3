/// Contains information about event.
class Event {
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;

  const Event({
    required this.content,
    this.isFavorite = false,
    this.isImage = false,
    required this.changeTime,
  });

  Event copyWith({
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
  }) {
    return Event(
      content: content ?? this.content,
      isImage: isImage ?? this.isImage,
      isFavorite: isFavorite ?? this.isFavorite,
      changeTime: changeTime ?? this.changeTime,
    );
  }
}
