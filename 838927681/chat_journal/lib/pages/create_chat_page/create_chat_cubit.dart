import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit({this.selectedIcon = 0})
      : super(
          CreateChatState(
            selectedIconIndex: selectedIcon,
            isNotEmpty: false,
            isCreatingMode: true,
            isChanged: false,
          ),
        );
  final int selectedIcon;

  void changeSelectedIconIndex(int index) {
    emit(state.copyWith(selectedIconIndex: index));
  }

  void changeIsNotEmpty(bool value) {
    emit(state.copyWith(isNotEmpty: value));
  }

  void isChangedToTrue() {
    emit(state.copyWith(isChanged: true));
  }
}
