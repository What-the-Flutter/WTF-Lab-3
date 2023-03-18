import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_editor_state.dart';

class ChatEditorCubit extends Cubit<ChatEditorState> {
  ChatEditorCubit() : super(const ChatEditorState());

  void selectIcon(int iconIndex) {
    emit(state.copyWith(iconIndex: iconIndex));
  }

  void changeTitle(String title) {
    emit(state.copyWith(title: title));
  }
}
