import 'package:flutter/cupertino.dart';

import '../models/chat.dart';

class ChatProvider extends ChangeNotifier {
  final chats = <Chat>[];
  final archivedChats = <Chat>[];

  void update() {
    notifyListeners();
  }
}
