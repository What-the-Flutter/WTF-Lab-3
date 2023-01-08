import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_final_project/data/db/db_provider.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(listChat: []));

  void initializer() async {
    final list = await DBProvider.dbProvider.getAllChat();
    emit(state.copyWith(listChat: _listChatSort(list)));
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
  }) async {
    final newChat = Chat(
      icon: icon,
      title: title,
      isPin: false,
      dateCreate: DateTime.now(),
    );
    final chat = await DBProvider.dbProvider.addChat(newChat);
    final newListChat = state.listChat;
    newListChat.add(chat);
    emit(state.copyWith(listChat: newListChat));
  }

  void changeSelectedIcon(Icon? icon) {
    if (icon == state.iconSeleted) {
      emit(state.copyWith(iconSeleted: null));
    } else {
      emit(state.copyWith(iconSeleted: icon));
    }
  }

  void deleteChat(int index) async {
    final newListChat = state.listChat;
    final element = newListChat[index];
    await DBProvider.dbProvider.deleteChat(element);
    newListChat.removeAt(index);
    emit(state.copyWith(listChat: newListChat));
  }

  void changePinChat(int index) async {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(isPin: !newChat.isPin);
    _listChatSort(newList);
    await DBProvider.dbProvider.updateChat(newChat.copyWith(isPin: !newChat.isPin));
    emit(state.copyWith(listChat: newList));
  }

  void changeEditMode() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  void editChat({
    required Icon icon,
    required String title,
    required int index,
  }) async {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(icon: icon, title: title);
    await DBProvider.dbProvider.updateChat(newChat.copyWith(icon: icon, title: title));
    emit(state.copyWith(listChat: newList));
    changeEditMode();
  }
}
