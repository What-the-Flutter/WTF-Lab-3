import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit()
      : super(
          MenuState(
            index: 0,
            menuStatus: MenuStatus.home,
          ),
        );

  void changeIndex(int index) {
    if (index == 2) {
      emit(state.copyWith(index: index, menuStatus: MenuStatus.timeline));
    } else {
      emit(state.copyWith(index: index, menuStatus: MenuStatus.home));
    }
  }
}
