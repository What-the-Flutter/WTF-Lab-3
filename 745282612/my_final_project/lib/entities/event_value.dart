import 'package:flutter/material.dart';
import 'package:my_final_project/entities/event.dart';

class EventValue {
  static final List<Event> listMessage = [
    Event(
      id: UniqueKey().hashCode,
      messageContent: 'Hello Maksim',
      messageType: 'sender',
      messageTime: DateTime.now(),
      isFavorit: true,
      isSelected: false,
    ),
    Event(
      id: UniqueKey().hashCode,
      messageContent: 'Hello Sasha r322222222222222222222222222222222r332r',
      messageType: 'recipient',
      messageTime: DateTime.now(),
      isFavorit: false,
      isSelected: false,
    ),
    Event(
      id: UniqueKey().hashCode,
      messageContent: 'Hello Vlada225523748321',
      messageType: 'sender',
      messageTime: DateTime.now(),
      isFavorit: false,
      isSelected: false,
    ),
  ];
}
