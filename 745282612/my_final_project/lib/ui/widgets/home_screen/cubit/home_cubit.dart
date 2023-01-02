import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/entities/chat_value.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(listChat: [])) {
    initializer();
  }

  void initializer() {
    final listChat = _listChatSort(ChatValue.listChat);
    emit(state.copyWith(listChat: listChat));
  }

  void updateInfo() {
    final listChat = state.listChat;
    emit(state.copyWith(listChat: listChat));
  }

  List<Chat> _listChatSort(List<Chat> listChat) {
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

  void addChat({
    required Icon icon,
    required String title,
  }) {
    final newChat = Chat(
      icon: icon,
      title: title,
      isPin: false,
      dateCreate: DateTime.now(),
      listEvent: [],
    );
    final newListChat = state.listChat;
    newListChat.add(newChat);
    emit(state.copyWith(listChat: newListChat));
  }

  void changeSelectedIcon(Icon? icon) {
    if (icon == state.iconSeleted) {
      emit(state.copyWith(iconSeleted: null));
    } else {
      emit(state.copyWith(iconSeleted: icon));
    }
  }

  void deleteChat(int index) {
    final newListChat = state.listChat;
    newListChat.removeAt(index);
    emit(HomeState(listChat: newListChat));
  }

  void changePinChat(int index) {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(isPin: !newList[index].isPin);
    _listChatSort(newList);
    emit(state.copyWith(listChat: newList));
  }

  void changeEditMode() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  void editChat({
    required Icon icon,
    required String title,
    required int index,
  }) {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(icon: icon, title: title);
    emit(state.copyWith(listChat: newList));
    changeEditMode();
  }
}
