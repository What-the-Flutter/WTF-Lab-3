// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:diary_app/domain/entities/event_category.dart';

class EventModel {
  int chatId;
  bool isFavorite;
  int dateTime;
  final bool isMessage;
  final String message;
  final String? categorytitle;
  final int? categoryIcon;
  final String? image;

  EventModel({
    required this.chatId,
    required this.isFavorite,
    required this.isMessage,
    required this.dateTime,
    required this.message,
    this.categorytitle,
    this.categoryIcon,
    this.image,
  });

  Event toEvent() {
    return Event(
      id: 0,
      chatId: chatId,
      isMessage: isMessage,
      dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime),
      message: message,
      image: (image != null) ? image : null,
      category: (categorytitle != null)
          ? EventCategory(
              title: categorytitle!,
              icon: allIcons[categoryIcon!],
            )
          : null,
    )..isFavorite = isFavorite;
  }

  EventModel.fromEvent(Event event)
      : chatId = event.chatId,
        isFavorite = event.isFavorite,
        isMessage = event.isMessage,
        dateTime = event.dateTime.millisecondsSinceEpoch,
        message = event.message,
        categorytitle = (event.category != null) ? event.category!.title : null,
        categoryIcon = (event.category != null) ? allIcons.indexOf(event.category!.icon) : null,
        image = (event.image == null) ? event.image.toString() : null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'isFavorite': boolToInt(isFavorite),
      'isMessage': boolToInt(isMessage),
      'dateTime': dateTime,
      'message': message,
      'categorytitle': categorytitle,
      'categoryIcon': categoryIcon,
      'image': image,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      chatId: map['chatId'] as int,
      isFavorite: intToBool(map['isFavorite']),
      isMessage: intToBool(map['isMessage']),
      dateTime: map['dateTime'] as int,
      message: map['message'] as String,
      categorytitle: map['categorytitle'] != null ? map['categorytitle'] as String : null,
      categoryIcon: map['categoryIcon'] != null ? map['categoryIcon'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

  static bool intToBool(int value) {
    return value == 1 ? true : false;
  }
}
