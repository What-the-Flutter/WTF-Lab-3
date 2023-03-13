import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:graduation_project/pages/home/home_cubit.dart';
import 'package:graduation_project/pages/searching_page.dart';
import 'package:graduation_project/widgets/date_card.dart';
import 'package:intl/intl.dart';

import '../../models/chat_model.dart';
import '../../widgets/event_card.dart';
import 'chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final Key chatId;

  const ChatPage({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textFieldController = TextEditingController();
  var _isEditingMode = false;
  var _isChoosingCategory = false;
  var _categoryIcon = Icons.bubble_chart;

  final FocusNode _myFocusNode = FocusNode();

  void _clearTextInput() {
    _textFieldController.clear();
  }

  Widget _createListViewItem(index, ChatState state) {
    final List<EventCardModel> cards = state.cards;

    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateCard(date: current.time),
          EventCard(cardModel: current, key: current.id),
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
            EventCard(cardModel: current, key: current.id),
          ],
        );
      }
      return EventCard(cardModel: current, key: current.id);
    }
  }

  void _onEnterEvent(String title) {
    if (!_isEditingMode) {
      final cardModel = EventCardModel(
        title: title,
        time: DateTime.now(),
        id: UniqueKey(),
        categoryIndex: categoryIcons.contains(_categoryIcon)
            ? categoryIcons.indexOf(_categoryIcon)
            : null,
      );
      context.read<ChatCubit>().addEventCard(cardModel);
      _clearTextInput();
    } else {
      context.read<ChatCubit>().editSelectedCard(title);
      _isEditingMode = false;
      _myFocusNode.unfocus();
      _clearTextInput();
    }
  }

  Widget _returnEvents(ChatState state) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        itemCount: state.cardsLength,
        reverse: true,
        itemBuilder: (_, index) {
          return _createListViewItem(index, state);
        },
      ),
    );
  }

  Widget _returnHintMessage(ChatModel chat) {
    if (chat.isShowingFavourites) {
      return Expanded(
        flex: 9,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColorDark.withAlpha(30),
          child: Column(
            children: [
              Text(
                'This is the page where you can track everything about "${chat.title}!"\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const Text(
                'You don\'t seem to have any bookmarked events yet. You can bookmark an event by single tapping the event',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 9,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColorDark.withAlpha(30),
          child: Column(
            children: [
              Text(
                'This is the page where you can track everything about "${chat.title}!"\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                'Add your first event to "${chat.title}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
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
  }

  List<SimpleDialogOption> _createOptions(
    HomeState state,
    BuildContext context,
  ) {
    return [
      for (int i = 0; i < state.chats.length; i++)
        if (state.chats[i].id != widget.chatId)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChatCubit>().moveSelectedCards(i);
            },
            child: Text(state.chats[i].title),
          ),
    ];
  }

  Future _onReplyChosen(HomeState state) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
              'Choose the chat you want to relocate selected events:'),
          children: _createOptions(state, context),
        );
      },
    );
  }

  onEditButtonPressed(ChatModel chat) {
    return List<EventCardModel>.from(chat.cards
                .where((EventCardModel element) => element.isSelected)).length >
            1
        ? null
        : () {
            _isEditingMode = true;
            _textFieldController.text =
                chat.cards.where((element) => element.isSelected).first.title;
            _myFocusNode.requestFocus();
          };
  }

  AppBar _createSelectionModeAppBar(chat, HomeState state) {
    final length =
        chat.cards.where((EventCardModel element) => element.isSelected).length;

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
      leading: IconButton(
        icon: const Icon(
          Icons.close,
        ),
        onPressed: () {
          context.read<ChatCubit>().cancelSelectionMode();
          if (_isEditingMode) {
            _isEditingMode = false;
            _textFieldController.text = '';
            _myFocusNode.unfocus();
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.edit,
          ),
          onPressed: onEditButtonPressed(chat),
          disabledColor: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: const Icon(
            Icons.reply,
          ),
          onPressed: () {
            _onReplyChosen(state);
          },
        ),
        IconButton(
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
        ),
        IconButton(
          icon: const Icon(
            Icons.bookmark_border_outlined,
          ),
          onPressed: () {
            context.read<ChatCubit>().manageFavouritesFromSelectionMode();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            context.read<ChatCubit>().deleteSelectedCards();
          },
        ),
      ],
    );
  }

  AppBar _createDefaultAppBar(ChatModel chat) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        chat.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchingPage(
                  cards: chat.cards,
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

  AppBar _createAppBar(BuildContext context, ChatModel chat, HomeState state) {
    if (List<EventCardModel>.from(
        chat.cards.where((element) => element.isSelected)).isNotEmpty) {
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
          itemCount: categoryIcons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(96)),
                      color: index == 0
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).hoverColor,
                    ),
                    child: Icon(
                      categoryIcons[index],
                      size: 32,
                      color: index == 0 ? Colors.red : Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (index != 0) {
                        _categoryIcon = categoryIcons[index];
                      } else {
                        _categoryIcon = Icons.bubble_chart;
                      }
                      _isChoosingCategory = false;
                    });
                  },
                ),
                Text(
                  categoryTitle[index],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatCubit>().init(widget.chatId);
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final chat = state.chat;
        final shouldShowMessage = chat.cards.isEmpty ||
            chat.isShowingFavourites &&
                chat.cards.where((element) => element.isFavourite).isEmpty;

        return Scaffold(
          appBar: _createAppBar(context, chat, context.read<HomeCubit>().state),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              shouldShowMessage
                  ? _returnHintMessage(chat)
                  : _returnEvents(state),
              Container(
                child: _isChoosingCategory ? _createCategoriesChoice() : null,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _isChoosingCategory = !_isChoosingCategory;
                              },
                            );
                          },
                          icon: Icon(
                            _categoryIcon,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textFieldController,
                            focusNode: _myFocusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Enter event',
                              filled: true,
                              fillColor:
                                  Theme.of(context).disabledColor.withAlpha(24),
                            ),
                            onSubmitted: (String? value) {
                              if (value != '') {
                                _onEnterEvent(value!);
                              }
                            },
                            onTap: () {
                              setState(
                                () {
                                  _isChoosingCategory = false;
                                },
                              );
                            },
                          ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
