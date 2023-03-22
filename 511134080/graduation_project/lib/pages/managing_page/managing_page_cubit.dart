import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';

part 'managing_page_state.dart';

class ManagingPageCubit extends Cubit<ManagingPageState> {
  final ChatRepository chatsRepository;

  ManagingPageCubit({
    required ManagingPageState initState,
    required this.chatsRepository,
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
    if (state.isCreatingPage) {
      await addChat(title);
    } else {
      await editChat(chatId, title);
    }
  }

  Future<void> addChat(String title) async {
    final reg = RegExp(r'[#\[\]]');
    final key = UniqueKey().toString();
    final chat = Chat(
      iconId: state.selectedIndex,
      title: title,
      id: key.replaceAll(reg, ''),
      date: DateTime.now(),
    );

    await chatsRepository.insertChat(chat);
  }

  Future<void> editChat(dynamic chatId, String newTitle) async {
    final chats = await chatsRepository.receiveAllChats();
    final chat = chats.where((chatModel) => chatModel.id == chatId).first;

    final editedChat = chat.copyWith(
      newIconId: state.selectedIndex,
      newTitle: newTitle,
    );
    await chatsRepository.updateChat(editedChat);
  }
}
