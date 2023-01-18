import 'package:flutter/cupertino.dart';

import '../models/chat.dart';

class ChatProvider extends ChangeNotifier {
  final chats = <Chat>[
    Chat(
      title: 'Travel',
      events: [],
      assetsLink: 'assets/plane.svg',
    ),
    Chat(
      title: 'Family',
      events: [],
      assetsLink: 'assets/sofa.svg',
    ),
    Chat(
      title: 'Travel',
      events: [],
      assetsLink: 'assets/gym.svg',
    ),
  ];

  void update() {
    notifyListeners();
  }
}
