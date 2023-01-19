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

  void delete(int index) {
    chats.removeAt(index);

    notifyListeners();
  }

  void edit(int index, {required String title, required IconData iconData}) {
    chats[index] = chats[index].copyWith(title: title, iconData: iconData);

    notifyListeners();
  }
}
