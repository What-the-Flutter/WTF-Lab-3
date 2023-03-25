import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/chat.dart';
import '../../models/event.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
import '../home/home_cubit.dart';
import '../searching_page/searching_page.dart';
import 'chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final String _chatId;

  const ChatPage({
    super.key,
    required String chatId,
  }) : _chatId = chatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textFieldController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();

  void _clearTextInput() {
    _textFieldController.clear();
  }

  Widget _createListViewItem(index, ChatState state) {
    final cards = state.events;

    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateCard(date: current.time),
          EventCard(
            cardModel: current,
            key: UniqueKey(),
          )
        ],
      );
    } else {
      final next = cards.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateCard(date: current.time),
            EventCard(
              cardModel: current,
              key: UniqueKey(),
            ),
          ],
        );
      }
      return EventCard(
        cardModel: current,
        key: UniqueKey(),
      );
    }
  }

  void _onEnterEvent(String title, ChatState state) {
    context.read<ChatCubit>().onEnterSubmitted(title);
    _myFocusNode.unfocus();
    _clearTextInput();
  }

  Widget _returnEvents(ChatState state) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        itemCount: state.eventsLength,
        reverse: true,
        itemBuilder: (_, index) {
          return _createListViewItem(index, state);
        },
      ),
    );
  }

  Widget _returnHintMessage(Chat chat, ChatState state) {
    final messages = state.hintMessages;
    return Expanded(
      flex: 9,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColorDark.withAlpha(30),
        child: Column(
          children: [
            Text(
              messages[0],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              messages[1],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  IconButton _createCloseButton() {
    return IconButton(
      icon: const Icon(
        Icons.close,
      ),
      onPressed: () {
        context.read<ChatCubit>().cancelSelectionMode();
        context.read<ChatCubit>().toggleEditingMode();
        _textFieldController.text = '';
        context.read<ChatCubit>().changeCategoryIcon(0);
        _myFocusNode.unfocus();
      },
    );
  }

  IconButton _createEditButton(Chat chat) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
      ),
      onPressed: _onEditButtonPressed(chat),
      disabledColor: Theme.of(context).primaryColor,
    );
  }

  Null Function()? _onEditButtonPressed(Chat chat) {
    final selectedLength = List<Event>.from(
        chat.events.where((Event cardModel) => cardModel.isSelected)).length;
    return selectedLength > 1
        ? null
        : () {
            context.read<ChatCubit>().toggleEditingMode(
                  editingMode: true,
                );
            final event = chat.events.where((Event e) => e.isSelected).first;
            _textFieldController.text = event.title;

            context.read<ChatCubit>().changeCategoryIcon(event.categoryIndex);
            _myFocusNode.requestFocus();
          };
  }

  IconButton _createReplyButton(state) {
    return IconButton(
      icon: const Icon(
        Icons.reply,
      ),
      onPressed: () {
        _onReplyChosen(state);
      },
    );
  }

  Future _onReplyChosen(HomeState state) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            state.chats.length > 1
                ? 'Choose the chat you want to relocate selected events:'
                : 'Error!',
            textAlign: TextAlign.center,
          ),
          children: state.chats.length > 1
              ? _createOptions(state, context)
              : [
                  const Text(
                    'There is only one chat. Create a new one to move your events!',
                    textAlign: TextAlign.center,
                  ),
                ],
        );
      },
    );
  }

  List<SimpleDialogOption> _createOptions(
    HomeState state,
    BuildContext context,
  ) {
    return [
      for (final chat in state.chats)
        if (chat.id != widget._chatId)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChatCubit>().moveSelectedCards(chat);
            },
            child: Text(chat.title),
          ),
    ];
  }

  IconButton _createCopyButton() {
    return IconButton(
      icon: const Icon(
        Icons.copy,
      ),
      onPressed: () {
        context.read<ChatCubit>().copySelectedCards();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Copied to the clipboard!',
            ),
          ),
        );
      },
    );
  }

  IconButton _createBookMarkButton() {
    return IconButton(
      icon: const Icon(
        Icons.bookmark_border_outlined,
      ),
      onPressed: () {
        context.read<ChatCubit>().manageFavouritesFromSelectionMode();
      },
    );
  }

  IconButton _createDeleteButton() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
      ),
      onPressed: () {
        context.read<ChatCubit>().deleteSelectedCards();
      },
    );
  }

  AppBar _createSelectionModeAppBar(Chat chat, HomeState state) {
    final length =
        chat.events.where((Event cardModel) => cardModel.isSelected).length;

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        '$length',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: 24,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      leading: _createCloseButton(),
      actions: [
        _createEditButton(chat),
        _createReplyButton(state),
        _createCopyButton(),
        _createBookMarkButton(),
        _createDeleteButton(),
      ],
    );
  }

  AppBar _createDefaultAppBar(Chat chat) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        chat.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context, context.read<ChatCubit>().state.chat);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchingPage(
                  cards: chat.events,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: chat.isShowingFavourites
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border_outlined),
          onPressed: () {
            context.read<ChatCubit>().toggleFavourites();
          },
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  AppBar _createAppBar(BuildContext context, Chat chat, HomeState state) {
    final isSelectionMode = context.read<ChatCubit>().state.isSelectionMode;
    if (isSelectionMode) {
      return _createSelectionModeAppBar(chat, state);
    } else {
      return _createDefaultAppBar(chat);
    }
  }

  Widget _createCategoriesChoice() {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: categoryIcons.length - 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(96)),
                        color: index == 0
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).hoverColor,
                      ),
                      child: Icon(
                        categoryIcons[index + 1],
                        size: 32,
                        color: index == 0 ? Colors.red : Colors.white,
                      ),
                    ),
                    onTap: () {
                      context.read<ChatCubit>().changeCategoryIcon(index + 1);
                      context.read<ChatCubit>().toggleChoosingCategory();
                    },
                  ),
                  Text(
                    categoryTitle[index + 1],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _createBottomBar(ChatState state) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<ChatCubit>().toggleChoosingCategory(
                        choosingCategory: !state.isChoosingCategory,
                      );
                },
                icon: Icon(
                  categoryIcons[state.categoryIconIndex],
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Expanded(
                child: _createTextField(state),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _createTextField(ChatState state) {
    return TextField(
      controller: _textFieldController,
      focusNode: _myFocusNode,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Enter event',
        filled: true,
        fillColor: Theme.of(context).disabledColor.withAlpha(24),
      ),
      onSubmitted: (value) {
        _onEnterEvent(value, state);
      },
      onTap: () {
        context.read<ChatCubit>().toggleChoosingCategory();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chat = context
        .read<HomeCubit>()
        .state
        .chats
        .where((Chat chatModel) => chatModel.id == widget._chatId)
        .first;

    context.read<ChatCubit>().init(chat);
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final chat = state.chat;
        final favourites = chat.events.where((Event e) => e.isFavourite);

        final shouldShowMessage = chat.events.isEmpty ||
            chat.isShowingFavourites && favourites.isEmpty;

        return Scaffold(
          appBar: _createAppBar(context, chat, context.read<HomeCubit>().state),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              shouldShowMessage
                  ? _returnHintMessage(chat, state)
                  : _returnEvents(state),
              state.isChoosingCategory
                  ? _createCategoriesChoice()
                  : Container(),
              _createBottomBar(state),
            ],
          ),
        );
      },
    );
  }
}
