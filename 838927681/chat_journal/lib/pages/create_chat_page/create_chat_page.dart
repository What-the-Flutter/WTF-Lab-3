import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/chat.dart';
import '../../../models/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/fonts.dart';
import '../../../theme/theme_cubit.dart';
import 'create_chat_cubit.dart';
import 'create_chat_state.dart';

class CreateChatPage extends StatefulWidget {
  CreateChatPage({
    required this.isCreatingMode,
    this.chat,
    super.key,
  });

  final _controller = TextEditingController();
  final bool isCreatingMode;
  final createChatCubit = CreateChatCubit();
  final Chat? chat;

  @override
  State<CreateChatPage> createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.chat != null) {
      widget._controller.text = widget.chat!.name;
    }
    return BlocProvider<CreateChatCubit>(
      create: (context) => widget.createChatCubit,
      child: BlocBuilder<CreateChatCubit, CreateChatState>(
        builder: (context, state) {
          if (!widget.isCreatingMode &&
              !widget.createChatCubit.state.isChanged) {
            widget.createChatCubit
                .changeSelectedIconIndex(widget.chat!.iconIndex);
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
                        widget.isCreatingMode
                            ? 'Create a new Page'
                            : 'Edit Page',
                        style: Fonts.createChatTitle,
                      ),
                      _inputPanel(),
                      _iconGrid(),
                    ],
                  ),
                  _floatingActionButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _inputPanel() {
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
            ? ChatJournalColors.iconGray
            : ChatJournalColors.darkGray,
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
          _textField(),
        ],
      ),
    );
  }

  Widget _textField() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 30),
      child: TextField(
        controller: widget._controller,
        onChanged: (text) {
          if (!widget.createChatCubit.state.isChanged) {
            widget.createChatCubit.isChangedToTrue();
          }
          widget.createChatCubit.changeIsNotEmpty(text.isNotEmpty);
        },
      ),
    );
  }

  Widget _iconGrid() {
    final selectedIndex = widget.createChatCubit.state.selectedIconIndex;
    return Flexible(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 70,
          crossAxisSpacing: 15,
          mainAxisSpacing: 30,
        ),
        itemCount: ChatJournalIcons.icons.length,
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
                      : ChatJournalColors.iconGray,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.createChatCubit.changeSelectedIconIndex(index);
                      if (!widget.createChatCubit.state.isChanged) {
                        widget.createChatCubit.isChangedToTrue();
                      }
                    });
                  },
                  child: Icon(
                    ChatJournalIcons.icons[index],
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

  Widget _floatingActionButton() {
    final isDone = widget._controller.text.isNotEmpty &&
        widget.createChatCubit.state.isChanged;
    return AnimatedPositioned(
      child: FloatingActionButton(
        //backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: Icon(
          isDone ? Icons.done : Icons.cancel_outlined,
          size: 40,
        ),
        onPressed: () {
          final Chat? chat;
          final isChanged = widget._controller.text.isNotEmpty &&
              widget.createChatCubit.state.isChanged;
          if (isChanged) {
            chat = Chat(
              name: widget._controller.text,
              iconIndex: widget.createChatCubit.state.selectedIconIndex,
              creationDate: DateTime.now(),
            );
          } else {
            chat = null;
          }
          Navigator.of(context).pop(chat);
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 0,
      bottom: 0,
      //curve: Curves.easeInOut,
    );
  }
}
