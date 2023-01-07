import 'package:flutter/material.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/event_value.dart';
import 'package:my_final_project/utils/custom_icons/custom_icons.dart';

class ChatValue {
  static final List<Chat> listChat = [
    Chat(
      id: UniqueKey().hashCode,
      icon: const Icon(CustomIcons.departure),
      title: 'Travel',
      isPin: false,
      // listEvent: EventValue.listMessage,
      dateCreate: DateTime.now(),
    ),
    Chat(
      id: UniqueKey().hashCode,
      icon: const Icon(CustomIcons.users),
      title: 'Family',
      isPin: true,
      // listEvent: [],
      dateCreate: DateTime.now(),
    ),
    Chat(
      id: UniqueKey().hashCode,
      icon: const Icon(CustomIcons.trophy_1),
      title: 'Sports',
      isPin: false,
      // listEvent: [],
      dateCreate: DateTime.now(),
    ),
  ];
}
