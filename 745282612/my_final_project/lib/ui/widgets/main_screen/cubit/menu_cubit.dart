import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/section.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  MenuCubit({this.user}) : super(MenuState(index: 0, listSection: [])) {
    initializer();
  }

  Future<void> initializer() async {
    final listSection = await firebase.getAllSection();
    emit(state.copyWith(listSection: listSection));
  }

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> addSection({
    required IconData iconData,
    required String title,
  }) async {
    final listSection = state.listSection;
    final newSection = Section(
      id: UniqueKey().hashCode,
      iconSection: iconData,
      titleSection: title,
    );
    await firebase.addSection(newSection);
    listSection.add(newSection);
    emit(state.copyWith(listSection: listSection));
  }

  void changeAddStatus() {
    emit(state.copyWith(isAdd: !state.isAdd));
  }
}
