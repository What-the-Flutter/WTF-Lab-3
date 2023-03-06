import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubits/events_cubit.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:graduation_project/widgets/date_card.dart';
import 'package:intl/intl.dart';

import '../models/chat_model.dart';
import '../widgets/event_card.dart';

class EventPage extends StatefulWidget {
  final Key chatId;

  const EventPage({
    super.key,
    required this.chatId,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _textFieldController = TextEditingController();
  var _isEditingMode = false;
  var _isShowingFavourites = false;
  final FocusNode _myFocusNode = FocusNode();

  void _clearTextInput() {
    _textFieldController.clear();
  }

  Widget _createListViewItem(index, chat) {
    final Iterable<EventCardModel> cards;

    if (_isShowingFavourites) {
      cards = List<EventCardModel>.from(
              chat.cards.where((EventCardModel element) => element.isFavourite))
          .reversed;
    } else {
      cards = chat.cards.reversed;
    }

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
      );
      context.read<EventsCubit>().addEventCard(widget.chatId, cardModel);
      _clearTextInput();
    } else {
      context.read<EventsCubit>().editSelectedCard(widget.chatId, title);
      _isEditingMode = false;
      _myFocusNode.unfocus();
      _clearTextInput();
    }
  }

  Widget _returnEvents(ChatModel chat) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        itemCount: _isShowingFavourites
            ? List<EventCardModel>.from(
                chat.cards.where((element) => element.isFavourite)).length
            : chat.cards.length,
        reverse: true,
        itemBuilder: (_, index) {
          return _createListViewItem(index, chat);
        },
      ),
    );
  }

  Widget _returnHintMessage(chat) {
    if (_isShowingFavourites) {
      return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColor.withAlpha(30),
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
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColor.withAlpha(30),
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
      );
    }
  }

  Future _onReplyChosen() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Title'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('First Option'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Second Option'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Other Option'),
            )
          ],
        );
      },
    );
  }

  AppBar _createAppBar(BuildContext context, ChatModel chat) {
    if (chat.cards.where((element) => element.isSelected).isNotEmpty) {
      return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${chat.cards.where((element) => element.isSelected).length}',
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
            context.read<EventsCubit>().cancelSelectionMode(widget.chatId);
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
            onPressed:
                chat.cards.where((element) => element.isSelected).length > 1
                    ? null
                    : () {
                        _isEditingMode = true;
                        _textFieldController.text = chat.cards
                            .where((element) => element.isSelected)
                            .first
                            .title;
                        _myFocusNode.requestFocus();
                      },
            disabledColor: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: const Icon(
              Icons.reply,
            ),
            onPressed: () {
              _onReplyChosen();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.copy,
            ),
            onPressed: () {
              context.read<EventsCubit>().copySelectedCards(widget.chatId);

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
              context
                  .read<EventsCubit>()
                  .manageFavouritesFromSelectionMode(widget.chatId);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              context.read<EventsCubit>().deleteSelectedCards(widget.chatId);
            },
          ),
        ],
      );
    } else {
      return AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          chat.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: _isShowingFavourites
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border_outlined),
            onPressed: () {
              setState(() {
                _isShowingFavourites = !_isShowingFavourites;
              });
            },
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
      final chat = state.getChatById(widget.chatId);
      return Scaffold(
        appBar: _createAppBar(context, chat),
        body: Column(
          children: [
            chat.cards.isEmpty ||
                    _isShowingFavourites &&
                        chat.cards
                            .where((element) => element.isFavourite)
                            .isEmpty
                ? _returnHintMessage(chat)
                : _returnEvents(chat),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bubble_chart,
                          color: Theme.of(context).primaryColor,
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
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Theme.of(context).primaryColor,
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
    });
  }
}
