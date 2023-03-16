import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';

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

  Future<void> manageChat(dynamic chatId, String title) async {
    if (state._isCreatingPage) {
      await addChat(title);
    } else {
      await editChat(chatId, title);
    }
  }

  Future<void> addChat(String title) async {
    final chat = Chat(
      iconId: state._selectedIndex,
      title: title,
      id: UniqueKey().toString(),
      date: DateTime.now(),
    );

    state._chat = chat;
    await state.chatsRepository.insertChat(chat);
  }

  Future<void> editChat(dynamic chatId, String newTitle) async {
    final chats = await state.chatsRepository.receiveAllChats();
    final chat = chats.where((chatModel) => chatModel.id == chatId).first;

    final editedChat = chat.copyWith(
      newIconId: state._selectedIndex,
      newTitle: newTitle,
    );
    state._chat = editedChat;
    await state.chatsRepository.updateChat(editedChat);
  }
}
