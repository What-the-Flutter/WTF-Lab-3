import 'package:equatable/equatable.dart';

class ChatDB extends Equatable {
  final String id;
  final String title;
  final int iconNumber;
  final String creationTime;
  final int isPin;
  final int isArchive;
  final String lastEvent;
  final String lastUpdate;

  const ChatDB({
    required this.id,
    required this.title,
    required this.iconNumber,
    required this.creationTime,
    required this.isPin,
    required this.isArchive,
    required this.lastEvent,
    required this.lastUpdate,
  });

  Map<String, dynamic> get map {
    return {
      ChatFields.id: id,
      ChatFields.title: title,
      ChatFields.iconNumber: iconNumber,
      ChatFields.creationTime: creationTime,
      ChatFields.isPin: isPin,
      ChatFields.isArchive: isArchive,
      ChatFields.lastEvent: lastEvent,
      ChatFields.lastUpdate: lastUpdate,
    };
  }

  ChatDB copyWith({
    String? id,
    String? title,
    int? iconNumber,
    String? creationTime,
    int? isPin,
    int? isArchive,
    String? lastEvent,
    String? lastUpdate,
  }) {
    return ChatDB(
      id: id ?? this.id,
      title: title ?? this.title,
      iconNumber: iconNumber ?? this.iconNumber,
      creationTime: creationTime ?? this.creationTime,
      isPin: isPin ?? this.isPin,
      isArchive: isArchive ?? this.isArchive,
      lastEvent: lastEvent ?? this.lastEvent,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  static ChatDB map2Json(Map<dynamic, dynamic> map) {
    return ChatDB(
      id: map[ChatFields.id] as String,
      title: map[ChatFields.title] as String,
      iconNumber: map[ChatFields.iconNumber] as int,
      creationTime: map[ChatFields.creationTime] as String,
      isPin: map[ChatFields.isPin] as int,
      isArchive: map[ChatFields.isArchive] as int,
      lastEvent: map[ChatFields.lastEvent] as String,
      lastUpdate: map[ChatFields.lastUpdate] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        iconNumber,
        creationTime,
        isPin,
        isArchive,
        lastEvent,
        lastUpdate,
      ];
}

class ChatFields {
  static String id = 'id';
  static String title = 'title';
  static String iconNumber = 'iconNumber';
  static String creationTime = 'creationTime';
  static String isPin = 'isPin';
  static String isArchive = 'isArchive';
  static String lastEvent = 'lastEvent';
  static String lastUpdate = 'lastUpdate';
}
