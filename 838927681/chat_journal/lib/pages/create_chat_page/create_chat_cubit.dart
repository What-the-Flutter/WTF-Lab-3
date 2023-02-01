import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  final int selectedIcon;
  final bool isCreatingMode;

  CreateChatCubit({required this.isCreatingMode, this.selectedIcon = 0})
      : super(
          CreateChatState(
            selectedIconIndex: selectedIcon,
            isNotEmpty: false,
            isCreatingMode: isCreatingMode,
            isChanged: false,
          ),
        );

  void changeSelectedIconIndex(int index) {
    emit(state.copyWith(selectedIconIndex: index));
  }

  void changeIsNotEmpty(bool value) {
    emit(state.copyWith(isNotEmpty: value));
  }

  void isChangedToTrue() {
    emit(state.copyWith(isChanged: true));
  }

  void setToEdit(Chat chat) {
    emit(
      state.copyWith(
        isCreatingMode: false,
        selectedIconIndex: chat.iconIndex,
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        selectedIconIndex: 0,
        isCreatingMode: true,
        isChanged: false,
      ),
    );
  }

  void incrementCounterId() {
    emit(state.copyWith(counterId: state.counterId + 1));
  }
}
