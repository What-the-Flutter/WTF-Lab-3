import 'package:flutter/material.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:graduation_project/widgets/date_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../providers/events_provider.dart';
import '../widgets/event_card.dart';

class EventPage extends StatefulWidget {
  final ChatModel chat;

  const EventPage({
    super.key,
    required this.chat,
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

  Widget _createListViewItem(index) {
    final Iterable<EventCardModel> cards;
    if (_isShowingFavourites) {
      cards = widget.chat.favouriteCards.reversed;
    } else {
      cards = widget.chat.allCards.reversed;
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
      widget.chat.allCards.add(cardModel);
      _clearTextInput();
      Provider.of<EventsProvider>(context, listen: false)
          .updateLastEvent(widget.chat);
    } else {
      Provider.of<EventsProvider>(context, listen: false)
          .editSelectedEventCard(widget.chat, title);
      _isEditingMode = false;
      _myFocusNode.unfocus();
      _textFieldController.text = '';
    }
  }

  Widget _returnEvents() {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        itemCount: _isShowingFavourites
            ? widget.chat.favouriteCards.length
            : widget.chat.allCards.length,
        reverse: true,
        itemBuilder: (_, index) {
          return Consumer<EventsProvider>(
            builder: (_, __, ___) => _createListViewItem(index),
          );
        },
      ),
    );
  }

  Widget _returnHintMessage() {
    if (_isShowingFavourites) {
      return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColor.withAlpha(30),
        child: Column(
          children: [
            Text(
              'This is the page where you can track everything about "${widget.chat.title}!"\n',
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
              'This is the page where you can track everything about "${widget.chat.title}!"\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Add your first event to "${widget.chat.title}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
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

  AppBar _createAppBar(BuildContext context) {
    if (widget.chat.selectedCards.isNotEmpty) {
      return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${widget.chat.selectedCards.length}',
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
            Provider.of<EventsProvider>(context, listen: false)
                .cancelSelectionMode(widget.chat);
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
            onPressed: widget.chat.selectedCards.length > 1
                ? null
                : () {
                    _isEditingMode = true;
                    _textFieldController.text =
                        widget.chat.selectedCards.first.title;
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
              Provider.of<EventsProvider>(
                context,
                listen: false,
              ).copySelectedCards(widget.chat);

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
              Provider.of<EventsProvider>(context, listen: false)
                  .manageFavouritesFromSelectionMode(widget.chat);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              Provider.of<EventsProvider>(context, listen: false)
                  .deleteSelectedCards(widget.chat);
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
          widget.chat.title,
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
    return Consumer<EventsProvider>(builder: (context, _, __) {
      return Scaffold(
        appBar: _createAppBar(context),
        body: Column(
          children: [
            widget.chat.allCards.isEmpty ||
                    _isShowingFavourites && widget.chat.favouriteCards.isEmpty
                ? _returnHintMessage()
                : _returnEvents(),
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
