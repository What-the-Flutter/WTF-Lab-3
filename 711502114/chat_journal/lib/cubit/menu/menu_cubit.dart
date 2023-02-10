import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(0));

  void choosePage(int pageIndex) {
    emit(state.copyWith(pageIndex));
  }
}
