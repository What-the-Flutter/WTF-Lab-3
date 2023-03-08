class Event {
  final int id;
  final int chatId;
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;
  final String? category;

  const Event({
    required this.id,
    required this.chatId,
    required this.content,
    required this.isImage,
    required this.isFavorite,
    required this.changeTime,
    required this.category,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      chatId: map['chatId'],
      content: map['content'],
      isImage: map['isImage'] != 0,
      isFavorite: map['isFavorite'] != 0,
      changeTime: DateTime.parse(map['changeTime']),
      category: map['category'],
    );
  } 

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'chatId': chatId,
      'content': content,
      'isImage': isImage ? 1 : 0,
      'isFavorite': isFavorite? 1 : 0,
      'changeTime': changeTime.toString(),
      'category': category,
    };
  }
}