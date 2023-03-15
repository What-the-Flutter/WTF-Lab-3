import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';

part 'managing_page_state.dart';

class ManagingPageCubit extends Cubit<ManagingPageState> {
  ManagingPageCubit({
    required ManagingPageState initState,
  }) : super(initState);

  void initState(Chat? chat) {
    if (chat == null) {
      emit(
        state.copyWith(
          index: 0,
          creatingPage: true,
          newInputText: '',
        ),
      );
    } else {
      emit(
        state.copyWith(
          index: chat.iconId,
          creatingPage: false,
          newInputText: chat.title,
          newTitle: 'Edit the Page \'${chat.title}\'',
        ),
      );
    }
  }

  void updateSelectedIcon(int index) {
    emit(
      state.copyWith(index: index),
    );
  }

  void updateInput(String input) {
    emit(
      state.copyWith(
        newInputText: input,
      ),
    );
  }

  void manageChat(dynamic chatId, String title) {
    if (state._isCreatingPage) {
      addChat(title);
    } else {
      editChat(chatId, title);
    }
  }

  void addChat(String title) {
    final chat = Chat(
      iconId: state._selectedIndex,
      title: title,
      id: UniqueKey().toString(),
      date: DateTime.now(),
      cards: const [],
    );

    final chats = List<Chat>.from([chat])..addAll(state._chats);

    emit(
      state.copyWith(
        newChats: chats,
      ),
    );

    state._resultPage = chat;
  }

  void editChat(dynamic chatId, String newTitle) {
    final chat =
        state._chats.where((chatModel) => chatModel.id == chatId).first;

    final editedChat = chat.copyWith(
      newIconId: state._selectedIndex,
      newTitle: newTitle,
    );

    updateChat(editedChat);
    state._resultPage = editedChat;
  }

  void updateChat(Chat editedChat) {
    final index =
        state._chats.indexWhere((element) => element.id == editedChat.id);

    final chats = state._chats;
    chats[index] = editedChat;

    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }
}
