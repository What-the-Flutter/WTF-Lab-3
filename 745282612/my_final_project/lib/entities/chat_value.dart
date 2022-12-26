import 'package:flutter/material.dart';

import '../ui/screens/travel_screen.dart';
import '../utils/custom_icons/custom_icons.dart';

import 'chat.dart';

class ChatValue {
  static final List<Chat> listChat = [
    Chat(
      icon: const Icon(CustomIcons.departure),
      title: 'Travel',
      // url: const TravelChat(),
      url: const TravelScreen(),
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
