import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_bottom_bar_state.dart';

class ChatBottomBarCubit extends Cubit<ChatBottomBarState> {
  ChatBottomBarCubit() : super(ChatBottomBarDefault());

  void changeState(String value) {
    if (state is ChatBottomBarFilled) {
      if (value.isEmpty) {
        emit(ChatBottomBarDefault());
      }
    } else {
      if (value.isNotEmpty) {
        emit(ChatBottomBarFilled());
      }
    }
  }
}
