class DBEvent {
  final int id;
  final int parentId;
  final String text;
  final String imagePath;
  final int iconIndex;
  final String dateTime;
  final int isFavorite;

  const DBEvent({
    required this.id,
    required this.parentId,
    required this.text,
    required this.dateTime,
    required this.imagePath,
    required this.iconIndex,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'text': text,
      'dateTime': dateTime,
      'imagePath': imagePath,
      'iconIndex': iconIndex,
      'isFavorite': isFavorite,
    };
  }
}
