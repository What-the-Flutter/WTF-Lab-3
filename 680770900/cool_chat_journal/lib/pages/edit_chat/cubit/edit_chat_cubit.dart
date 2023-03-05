import 'package:bloc/bloc.dart';

import 'edit_chat_state.dart';

class EditChatCubit extends Cubit<EditChatState> {
  EditChatCubit() : super(const EditChatState());

  void selectIcon(int iconIndex) {
    emit(state.copyWith(iconIndex: iconIndex));
  }

  void changeTitle(String title) {
    emit(state.copyWith(title: title));
  }
  
}