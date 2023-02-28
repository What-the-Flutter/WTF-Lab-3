class ChatDB {
  final int id;
  final String title;
  final int iconNumber;
  final String creationTime;
  final int isPin;
  final int isArchive;

  const ChatDB({
    required this.id,
    required this.title,
    required this.iconNumber,
    required this.creationTime,
    required this.isPin,
    required this.isArchive,
  });

  Map<String, dynamic> map() {
    return {
      ChatFields.id: id,
      ChatFields.title: title,
      ChatFields.iconNumber: iconNumber,
      ChatFields.creationTime: creationTime,
      ChatFields.isPin: isPin,
      ChatFields.isArchive: isArchive,
    };
  }
}

class ChatFields {
  static String id = 'id';
  static String title = 'title';
  static String iconNumber = 'iconNumber';
  static String creationTime = 'creationTime';
  static String isPin = 'isPin';
  static String isArchive = 'isArchive';
}
