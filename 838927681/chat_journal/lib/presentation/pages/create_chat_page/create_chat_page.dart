import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/fonts.dart';
import '../settings_page/settings_cubit.dart';
import 'create_chat_cubit.dart';
import 'create_chat_state.dart';

class CreateChatPage extends StatelessWidget {
  final _controller = TextEditingController();
  final Chat? chat;
  late final CreateChatCubit createChatCubit;

  CreateChatPage({
    this.chat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    return BlocBuilder<CreateChatCubit, CreateChatState>(
      builder: (context, state) {
        if (chat != null && !state.isChanged) {
          createChatCubit.setToEdit(chat!);
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: BlocProvider.of<SettingsCubit>(context).isLight()
                  ? ChatJournalColors.white
                  : ChatJournalColors.black,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 30.0,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      chat != null ? 'Create a new Page' : 'Edit Page',
                      style: Fonts.createChatTitle,
                    ),
                    _inputPanel(state, context),
                    _iconGrid(state, context),
                  ],
                ),
                _floatingActionButton(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputPanel(CreateChatState state, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: BlocProvider.of<SettingsCubit>(context).isLight()
            ? ChatJournalColors.iconGrey
            : ChatJournalColors.darkGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of the Page',
            style: Fonts.createChatInputTitle,
            textAlign: TextAlign.left,
          ),
          _textField(state, context),
        ],
      ),
    );
  }

  Widget _textField(CreateChatState state, BuildContext context) {
    if (!state.isChanged && !state.isCreatingMode) {
      _controller.text = chat!.name;
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 30),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          if (!state.isChanged) {
            createChatCubit.isChangedToTrue();
          }
          createChatCubit.changeIsNotEmpty(text.isNotEmpty);
        },
      ),
    );
  }

  Widget _iconGrid(CreateChatState state, BuildContext context) {
    final selectedIndex = state.selectedIconIndex;
    return Flexible(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 70,
          crossAxisSpacing: 15,
          mainAxisSpacing: 30,
        ),
        itemCount: ChatJournalIcons.chatIcons.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: BlocProvider.of<SettingsCubit>(context).isLight()
                      ? Colors.blueGrey
                      : ChatJournalColors.iconGrey,
                ),
                child: GestureDetector(
                  onTap: () {
                    createChatCubit.changeSelectedIconIndex(index);
                    if (!state.isChanged) {
                      createChatCubit.isChangedToTrue();
                    }
                  },
                  child: Icon(
                    ChatJournalIcons.chatIcons[index],
                    color: Theme.of(context).backgroundColor,
                    size: 30,
                  ),
                ),
              ),
              index == selectedIndex ? _selectedIcon() : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _selectedIcon() {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ChatJournalColors.accentYellow,
        ),
        child: const Icon(
          Icons.done,
          size: 10,
          color: ChatJournalColors.white,
        ),
      ),
    );
  }

  Widget _floatingActionButton(CreateChatState state, BuildContext context) {
    final isDone = _controller.text.isNotEmpty && state.isChanged;
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: Icon(
          isDone ? Icons.done : Icons.cancel_outlined,
          size: 40,
        ),
        onPressed: () async {
          final isChanged = _controller.text.isNotEmpty && state.isChanged;
          if (isChanged) {
            final date = DateTime.now();
            if (state.isCreatingMode) {
              final chat = Chat(
                id: '',
                name: _controller.text,
                iconIndex: state.selectedIconIndex,
                creationDate: date,
                lastDate: date,
              );
              createChatCubit.addChat(chat);
            } else {
              await createChatCubit.updateChat(
                  chat!.id, _controller.text, state.selectedIconIndex);
            }
          }
          createChatCubit.reset();
          Navigator.of(context).pop();
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 0,
      bottom: 0,
    );
  }
}
