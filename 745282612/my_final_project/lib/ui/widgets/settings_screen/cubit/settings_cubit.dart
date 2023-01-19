import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/section.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  SettingsCubit({this.user}) : super(SettingsState(listSection: [])) {
    initializer();
  }

  Future<void> initializer() async {
    final listSection = await firebase.getAllSection();
    emit(state.copyWith(listSection: listSection));
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
