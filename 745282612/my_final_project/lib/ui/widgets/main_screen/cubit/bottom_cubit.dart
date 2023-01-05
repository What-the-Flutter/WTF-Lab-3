import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/main_screen/cubit/bottom_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(index: 0));

  void changeIndex(int index) {
    emit(state.copyWith(index));
  }
}
