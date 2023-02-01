import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/chat.dart';
import '../../../models/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/fonts.dart';
import '../../../theme/theme_cubit.dart';
import '../home_page/home_page_cubit.dart';
import 'create_chat_cubit.dart';
import 'create_chat_state.dart';

class CreateChatPage extends StatelessWidget {
  final _controller = TextEditingController();
  final bool isCreatingMode;
  final String initialText;
  final int iconIndex;

  CreateChatPage({
    required this.isCreatingMode,
    this.initialText = '',
    this.iconIndex = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    return BlocBuilder<CreateChatCubit, CreateChatState>(
      builder: (context, state) {
        if (!isCreatingMode && !state.isChanged) {
          createChatCubit.changeSelectedIconIndex(iconIndex);
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: BlocProvider.of<ThemeCubit>(context).isLight()
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
                      isCreatingMode ? 'Create a new Page' : 'Edit Page',
                      style: Fonts.createChatTitle,
                    ),
                    _inputPanel(context),
                    _iconGrid(context),
                  ],
                ),
                _floatingActionButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputPanel(context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: BlocProvider.of<ThemeCubit>(context).isLight()
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
          _textField(context),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    final createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    if (!createChatCubit.state.isChanged &&
        !createChatCubit.state.isCreatingMode) {
      _controller.text = initialText;
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 30),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          if (!createChatCubit.state.isChanged) {
            createChatCubit.isChangedToTrue();
          }
          createChatCubit.changeIsNotEmpty(text.isNotEmpty);
        },
      ),
    );
  }

  Widget _iconGrid(BuildContext context) {
    final createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    final selectedIndex = createChatCubit.state.selectedIconIndex;
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
                  color: BlocProvider.of<ThemeCubit>(context).isLight()
                      ? Colors.blueGrey
                      : ChatJournalColors.iconGrey,
                ),
                child: GestureDetector(
                  onTap: () {
                    createChatCubit.changeSelectedIconIndex(index);
                    if (!createChatCubit.state.isChanged) {
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

  Widget _floatingActionButton(BuildContext context) {
    final createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    final isDone =
        _controller.text.isNotEmpty && createChatCubit.state.isChanged;
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: Icon(
          isDone ? Icons.done : Icons.cancel_outlined,
          size: 40,
        ),
        onPressed: () {
          final Chat? chat;
          final isChanged =
              _controller.text.isNotEmpty && createChatCubit.state.isChanged;
          if (isChanged) {
            final date =DateTime.now();
            chat = Chat(
              id: _generateId(context),
              name: _controller.text,
              iconIndex: createChatCubit.state.selectedIconIndex,
              creationDate: date,
            );
          } else {
            chat = null;
          }
          Navigator.of(context).pop(chat);
          createChatCubit.reset();
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 0,
      bottom: 0,
    );
  }

  int _generateId(BuildContext context) {
    final createChatCubit = BlocProvider.of<CreateChatCubit>(context);
    final homeState = BlocProvider.of<HomePageCubit>(context).state;

    var generated = false;
    while (!generated) {
      var exist = false;
      var i = 0;
      while (i < homeState.chats.length && !exist) {
        if (homeState.chats[i].id == createChatCubit.state.counterId) {
          exist = true;
        } else {
          i++;
        }
      }
      if (!exist) {
        generated = true;
      }
      createChatCubit.incrementCounterId();
    }
    return createChatCubit.state.counterId;
  }
}
