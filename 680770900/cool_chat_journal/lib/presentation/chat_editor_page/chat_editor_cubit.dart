import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/chat.dart';
import '../home_page/home_cubit.dart';

part 'chat_editor_state.dart';

class ChatEditorCubit extends Cubit<ChatEditorState> {
  final HomeCubit homeCubit;

  ChatEditorCubit({
    required this.homeCubit,
  }) : super(const ChatEditorState());

  void selectIcon(int iconIndex) {
    emit(state.copyWith(iconIndex: iconIndex));
  }

  void changeTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void addChat(Chat chat) => homeCubit.addChat(chat);

  void editChat(Chat chat) => homeCubit.editChat(chat);

}
