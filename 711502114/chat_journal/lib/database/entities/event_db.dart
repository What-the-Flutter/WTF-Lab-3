class EventDB {
  final int id;
  final int chatId;
  final String message;
  final String creationTime;
  final int isFavorite;
  final String photoPath;
  final String categoryName;

  const EventDB({
    required this.id,
    required this.chatId,
    required this.message,
    required this.creationTime,
    required this.isFavorite,
    required this.photoPath,
    required this.categoryName,
  });

  Map<String, dynamic> map() {
    return {
      EventFields.id: id,
      EventFields.chatId: chatId,
      EventFields.message: message,
      EventFields.creationTime: creationTime,
      EventFields.isFavorite: isFavorite,
      EventFields.photoPath: photoPath,
      EventFields.categoryName: categoryName,
    };
  }
}

class EventFields {
  static String id = 'id';
  static String chatId = 'chatId';
  static String message = 'message';
  static String creationTime = 'creationTime';
  static String isFavorite = 'isFavorite';
  static String photoPath = 'photoPath';
  static String categoryName = 'categoryName';
}
