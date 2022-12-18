import 'package:flutter/material.dart';
import '../custom_icons/custom_icons.dart';

import 'chat.dart';

class ChatValue {
  static final List<Chat> listChat = [
    Chat(
      icon: const Icon(CustomIcons.departure),
      title: 'Travel',
    ),
    Chat(
      icon: const Icon(CustomIcons.users),
      title: 'Family',
    ),
    Chat(
      icon: const Icon(CustomIcons.trophy_1),
      title: 'Sports',
    ),
  ];
}
