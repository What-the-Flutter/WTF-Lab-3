import 'package:bloc/bloc.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  void toggleEditMode() {
    emit(state.copyWith(
      isEditMode: !state.isEditMode,
      selectedEvents: const [],
    ));
  }

  void toggleFavoriteMode() {
    emit(state.copyWith(
      isFavoriteMode: !state.isFavoriteMode,
      selectedEvents: const [],
    ));
  }

  void resetSelection() {
    emit(state.copyWith(
      selectedEvents: const [],
    ));
  }
}