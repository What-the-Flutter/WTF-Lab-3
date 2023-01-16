import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  HomeCubit({this.user}) : super(HomeState(listChat: [])) {
    initializer();
  }

  Future<void> initializer() async {
    final list = await firebase.getAllChat();
    emit(state.copyWith(listChat: list));
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

  Future<void> addChat({
    required Icon icon,
    required String title,
  }) async {
    final newChat = Chat(
      id: UniqueKey().hashCode,
      icon: icon,
      title: title,
      isPin: false,
      dateCreate: DateTime.now(),
    );
    await firebase.addChat(newChat);
    final newListChat = state.listChat;
    newListChat.insert(0, newChat);
    emit(state.copyWith(listChat: _listChatSort(newListChat)));
  }

  void changeSelectedIcon(Icon? icon) {
    if (icon == state.iconSeleted) {
      emit(state.copyWith(iconSeleted: null));
    } else {
      emit(state.copyWith(iconSeleted: icon));
    }
  }

  Future<void> deleteChat(int index) async {
    final newListChat = state.listChat;
    final element = newListChat[index];
    await firebase.deleteChat(element);
    newListChat.removeAt(index);
    emit(state.copyWith(listChat: newListChat));
  }

  Future<void> changePinChat(int index) async {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(isPin: !newChat.isPin);
    _listChatSort(newList);
    await firebase.updateChat(newChat.copyWith(isPin: !newChat.isPin));
    emit(state.copyWith(listChat: newList));
  }

  void changeEditMode() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  Future<void> editChat({
    required Icon icon,
    required String title,
    required int index,
  }) async {
    final newList = state.listChat;
    final newChat = state.listChat[index];
    newList[index] = newChat.copyWith(icon: icon, title: title);
    await firebase.updateChat(newChat.copyWith(icon: icon, title: title));
    emit(state.copyWith(listChat: newList));
    changeEditMode();
  }
}
