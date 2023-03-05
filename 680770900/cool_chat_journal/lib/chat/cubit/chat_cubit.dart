import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState(chat: Chat.empty));

  void toggleEditMode() {
    emit(state.copyWith(
      isEditMode: !state.isEditMode,
    ));
  }

  void toggleFavoriteMode() {
    emit(state.copyWith(
      isFavoriteMode: !state.isFavoriteMode,
    ));
  }

  void resetSelection() {
    emit(state.copyWith(
      selectedEventsIds: const [],
    ));
  }
}
