import 'package:equatable/equatable.dart';

class EventDB extends Equatable {
  final String id;
  final String chatId;
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

  Map<String, dynamic> get map {
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

  EventDB copyWith({
    String? id,
    String? chatId,
    String? message,
    String? creationTime,
    int? isFavorite,
    String? photoPath,
    String? categoryName,
  }) {
    return EventDB(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      message: message ?? this.message,
      creationTime: creationTime ?? this.creationTime,
      isFavorite: isFavorite ?? this.isFavorite,
      photoPath: photoPath ?? this.photoPath,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  static EventDB map2Json(Map<dynamic, dynamic> map) {
    return EventDB(
      id: map[EventFields.id] as String,
      chatId: map[EventFields.chatId] as String,
      message: map[EventFields.message] as String,
      creationTime: map[EventFields.creationTime] as String,
      isFavorite: map[EventFields.isFavorite] as int,
      photoPath: map[EventFields.photoPath] as String,
      categoryName: map[EventFields.categoryName] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        message,
        creationTime,
        isFavorite,
        photoPath,
        categoryName,
      ];
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
