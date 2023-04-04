import 'package:flutter/foundation.dart';

@immutable
class Event {
  final String id;
  final int categoryIndex;
  final String title;
  final String? imagePath;
  final DateTime time;
  final bool isFavourite;
  final bool isSelected;
  final String chatId;
  final String chatTitle;

  const Event({
    required this.title,
    required this.time,
    required this.id,
    required this.chatId,
    required this.chatTitle,
    this.isFavourite = false,
    this.isSelected = false,
    this.categoryIndex = 0,
    this.imagePath,
  });

  Event copyWith({
    String? newTitle,
    DateTime? newTime,
    dynamic newId,
    dynamic newChatId,
    bool? isFavourite,
    bool? isSelected,
    int? newCategory,
    String? newImagePath,
    String? newChatTitle,
  }) {
    return Event(
      title: newTitle ?? title,
      time: newTime ?? time,
      id: newId ?? id,
      chatId: newChatId ?? chatId,
      isFavourite: isFavourite ?? this.isFavourite,
      isSelected: isSelected ?? this.isSelected,
      categoryIndex: newCategory ?? categoryIndex,
      imagePath: newImagePath ?? imagePath,
      chatTitle: newChatTitle ?? chatTitle,
    );
  }

  factory Event.fromDatabaseMap(Map<String, dynamic> data) => Event(
        title: data['title'],
        time: DateTime.parse(data['time']),
        id: data['id'],
        chatId: data['chat_id'],
        categoryIndex: data['category_index'],
        isFavourite: data['is_favourite'] == 1 ? true : false,
        isSelected: data['is_selected'] == 1 ? true : false,
        imagePath: data['image_path'],
        chatTitle: data['chat_title'],
      );

  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'time': time.toString(),
        'id': id,
        'chat_id': chatId,
        'category_index': categoryIndex,
        'is_favourite': isFavourite ? 1 : 0,
        'is_selected': isSelected ? 1 : 0,
        'image_path': imagePath,
        'chat_title': chatTitle,
      };
}
