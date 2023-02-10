import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/source.dart';
import '../../models/chat.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int _id = 0;

  HomeCubit() : super(HomeState(chats: sourceChats));

  void update() {
    emit(state.copyWith(chats: state.chats));
  }

  void add({required String title, required IconData iconData}) {
    state.chats.add(
      Chat(
        id: _id++,
        title: title,
        events: [],
        iconData: iconData,
        creationTime: DateTime.now(),
      ),
    );

    update();
  }

  void delete(int id) {
    state.chats.removeWhere((chat) => chat.id == id);

    update();
  }

  void edit(int id, {required String title, required IconData iconData}) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(
      title: title,
      iconData: iconData,
    );

    update();
  }

  void changePin(int id) {
    final index = _findIndexById(id);

    final isPin = state.chats[index].isPin;
    state.chats[index] = state.chats[index].copyWith(isPin: !isPin);

    state.chats.sort((a, b) {
      if (b.isPin && a == b) {
        return a.creationTime.compareTo(b.creationTime);
      } else if (b.isPin) {
        return 1;
      } else {
        return -1;
      }
    });

    update();
  }

  void archive(int id, [bool isArchive = true]) {
    final index = _findIndexById(id);

    state.chats[index] = state.chats[index].copyWith(isArchive: isArchive);

    update();
  }

  int _findIndexById(int id) {
    final chats = state.chats;
    return chats.indexOf(chats.firstWhere((chat) => chat.id == id));
  }
}
