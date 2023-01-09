import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/data/db/db_provider.dart';
import 'package:my_final_project/entities/section.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(index: 0, listSection: [])) {
    initializer();
  }

  void initializer() async {
    final listSection = await DBProvider.dbProvider.getAllSection();
    emit(state.copyWith(listSection: listSection));
  }

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void addSection({
    required IconData iconData,
    required String title,
  }) async {
    final listSection = state.listSection;
    final newSection = await DBProvider.dbProvider.addSection(Section(
      iconSection: iconData,
      titleSection: title,
    ));
    listSection.add(newSection);
    emit(state.copyWith(listSection: listSection));
  }

  void changeAddStatus() {
    emit(state.copyWith(isAdd: !state.isAdd));
  }
}
