import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../home/home_cubit.dart';

part 'managing_page_state.dart';

class ManagingPageCubit extends Cubit<ManagingPageState> {
  final HomeCubit homeCubit;
  ManagingPageCubit({
    required this.homeCubit,
    required ManagingPageState initState,
  }) : super(initState);

  void addChat(int iconId, String title) {
    final chat = [
      ChatModel(
        iconId: iconId,
        title: title,
        id: UniqueKey(),
        date: DateTime.now(),
        cards: const [],
      )
    ];

    final chats = List<ChatModel>.from(chat)..addAll(state.chats);

    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
    homeCubit.updateChats(chat.first);
  }

  void editChat(chatId, newIconId, newTitle) {
    final chat = state.chats
        .where((ChatModel chatModel) => chatModel.id == chatId)
        .first;

    final editedChat = chat.copyWith(
      newIconId: newIconId,
      newTitle: newTitle,
    );

    updateChat(editedChat);
    homeCubit.updateChats(editedChat);
  }

  void updateChat(ChatModel editedChat) {
    final index =
        state.chats.indexWhere((element) => element.id == editedChat.id);

    final chats = state.chats;
    chats[index] = editedChat;

    emit(
      state.copyWith(
        newChats: chats,
      ),
    );
  }
}
