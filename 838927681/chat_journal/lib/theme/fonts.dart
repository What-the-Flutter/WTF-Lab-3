import 'package:flutter/material.dart';

import 'colors.dart';

class Fonts {
  static final drawerFont = const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final questionnaireBotLightFont = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16,
  );

  static final questionnaireBotDarkFont = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );

  static final mainPageChatTitle = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  static final chatPageTitle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static final eventFont = const TextStyle(
    fontSize: 16,
  );

  static final eventDateFont = const TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  static final chatWithNoEventsFont = const TextStyle(
    fontSize: 18,
  );

  static final createChatTitle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final createChatInputTitle = const TextStyle(
    fontSize: 16,
    color: ChatJournalColors.accentYellow,
  );

  static final chatMenuFont = const TextStyle(
    fontSize: 18,
  );
}
