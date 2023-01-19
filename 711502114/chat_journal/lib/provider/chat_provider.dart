import 'package:flutter/cupertino.dart';

import '../models/chat.dart';

class ChatProvider extends ChangeNotifier {
  final chats = <Chat>[];

  void update() {
    notifyListeners();
  }

  void add({required String title, required IconData iconData}) {
    chats.add(
      Chat(
        title: title,
        events: [],
        iconData: iconData,
        creationTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
