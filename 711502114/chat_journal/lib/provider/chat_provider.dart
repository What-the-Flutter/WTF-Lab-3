import 'package:flutter/cupertino.dart';

import '../models/chat.dart';

class ChatProvider extends ChangeNotifier {
  final chats = <Chat>[];
  final archivedChats = <Chat>[];

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

  void changePin(int index) {
    final isPin = chats[index].isPin;
    chats[index] = chats[index].copyWith(isPin: !isPin);

    chats.sort((a, b) {
      if (b.isPin && a == b) {
        return a.creationTime.compareTo(b.creationTime);
      } else if (b.isPin) {
        return 1;
      } else {
        return -1;
      }
    });

    notifyListeners();
  }

  void archive(int index) {
    chats[index] = chats[index].copyWith(isArchive: true);

    archivedChats.add(chats[index]);
    delete(index);
  }

  void unarchive(int index) {
    chats[index] = chats[index].copyWith(isArchive: false);

    chats.add(archivedChats[index]);
    archivedChats.removeAt(index);

    notifyListeners();
  }
}
