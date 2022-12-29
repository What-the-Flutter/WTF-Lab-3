import 'package:flutter/material.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/chat_value.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> listChat = ChatValue.listChat;
  final inputController = TextEditingController();
  bool isStatus = false;
  bool isEditeMode = false;
  int indexEdit = -1;
  Icon? editIcon;
  bool update = false;

  void isUpdate() {
    update = !update;
    notifyListeners();
  }

  void startEditeMode({
    required String title,
    required int index,
    required Icon icon,
  }) {
    indexEdit = index;
    editIcon = icon;
    isEditeMode = !isEditeMode;
    inputController.text = title;
    notifyListeners();
  }

  void listenerController() {
    if (inputController.text.isNotEmpty) {
      isStatus = true;
    } else {
      isStatus = false;
    }
  }

  void addNewChat({
    required Icon icon,
    required String title,
  }) {
    listChat.add(
      Chat(
        icon: icon,
        title: title,
        isPin: false,
        listEvent: [],
        dateCreate: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void changePin({required int index}) {
    var chat = listChat[index];
    listChat[index] = chat.copyWith(isPin: !chat.isPin);
    notifyListeners();
  }

  void endModify() {
    inputController.text = '';
    indexEdit = -1;
    isEditeMode = !isEditeMode;
  }

  void modifyChat({
    required Icon icon,
    required String title,
  }) {
    var chat = listChat[indexEdit];
    listChat[indexEdit] = chat.copyWith(icon: icon, title: title);
    inputController.text = '';
    indexEdit = -1;
    isEditeMode = !isEditeMode;
    notifyListeners();
  }

  void deleteChat({required int index}) {
    listChat.removeAt(index);
    notifyListeners();
  }

  List<Chat> get takeListChat {
    listChat.sort(
      (a, b) {
        if (b.isPin) {
          return 1;
        }
        return -1;
      },
    );
    return listChat;
  }
}
