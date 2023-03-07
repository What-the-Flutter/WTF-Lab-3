import 'package:flutter/foundation.dart';
import 'package:graduation_project/models/event_card_model.dart';

@immutable
class ChatModel {
  final dynamic id;
  final int iconId;
  final String title;
  final EventCardModel? lastEvent;

  final List<EventCardModel> cards;

  const ChatModel({
    required this.iconId,
    required this.title,
    required this.id,
    required this.cards,
    this.lastEvent,
  });

  ChatModel copyWith({
    dynamic newId,
    int? newIconId,
    String? newTitle,
    EventCardModel? newLastEvent,
    List<EventCardModel>? newCards,
  }) {
    return ChatModel(
      id: newId ?? id,
      iconId: newIconId ?? iconId,
      title: newTitle ?? title,
      lastEvent: newLastEvent ?? lastEvent,
      cards: newCards ?? cards,
    );
  }
}
