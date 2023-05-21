import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../notifiers/event_notifier.dart';
import '../widgets/date_widget.dart';
import '../widgets/event_widget.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key, required this.chat});

  final Chat chat;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var _edit = false;
  var _favourites = false;

  Widget _showMessages(BuildContext context) {
    final listOfEvents =
        _favourites ? widget.chat.events.where((element) => element.isFavourite) : widget.chat.events;
    if (listOfEvents.isNotEmpty) {
      return Expanded(
        flex: 8,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Consumer<EventsNotifier>(
              builder: (context, provider, child) => _eventTile(index),
            );
          },
          reverse: true,
          itemCount: listOfEvents.length,
        ),
      );
    } else {
      return _getHint(context);
    }
  }

  Widget _eventTile(index) {
    final favourites = widget.chat.events.where((element) => element.isFavourite).toList();
    final events = _favourites
        ? favourites.reversed
        : widget.chat.events.reversed;
    final current = events.elementAt(index);

    if (events.length == 1 || index == events.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Date(date: current.date),
          EventWidget(
            event: current,
            key: current.key,
          ),
        ],
      );
    } else {
      final next = events.elementAt(index + 1);
      if (DateFormat.yMMMMd('en_US').format(current.date) !=
          DateFormat.yMMMMd('en_US').format(next.date)) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Date(date: current.date),
            EventWidget(
              event: current,
              key: current.key,
            ),
          ],
        );
      }
      return EventWidget(
        event: current,
        key: current.key,
      );
    }
  }

  Container _getHint(BuildContext context) {
    final text = _favourites
        ? 'You don\'t seem to have any bookmarked events '
            'yet. You can bookmark an event by single tapping the event.'
        : 'Add your first event to "${widget.chat.name}" page by entering'
            ' some text in the box below and hitting the send button.'
            'Long tap the send button to align the event in the opposite'
            ' direction. Tap on the bookmark icon on the top right corner'
            ' to show the bookmarked events only.';
    return Container(
      color: Theme.of(context).colorScheme.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            'This is the page where you can track everything about'
            ' "${widget.chat.name}"!',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _addMessage(BuildContext context, String text) {
    if (!_edit) {
      widget.chat.events.add(Event(
        text: text,
        key: UniqueKey(),
        date: DateTime.now(),
      ));
    } else {
      _edit = false;
      Provider.of<EventsNotifier>(context, listen: false)
          .changeEvent(widget.chat, text);
      focusNode.unfocus();
    }
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    final bgColor = theme.colorScheme.onPrimary;

    return Consumer<EventsNotifier>(builder: (context, provider, child) {
      return Scaffold(
        //consumer
        appBar: _getAppBar(context, bgColor),
        body: Column(
          children: [
            _showMessages(context),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bubble_chart),
                        color: bgColor,
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          focusNode: focusNode,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintStyle: style,
                            hintText: 'Enter event',
                          ),
                          style: style,
                          onSubmitted: (input) {
                            if (input != '') {
                              _addMessage(context, input);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_enhance_outlined),
                        color: bgColor,
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

  AppBar _getAppBar(BuildContext context, Color bgColor) {
    final favouritesColor = _favourites ? Colors.amber : bgColor;
    final favouritesIcon =
        _favourites ? Icons.bookmark_outlined : Icons.bookmark_border;
    return AppBar(
      title: Text(widget.chat.name),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if (_edit) {
            Provider.of<EventsNotifier>(context, listen: false)
                .errorChangeEvent(widget.chat);
            _edit = false;
            _textEditingController.clear();
            focusNode.unfocus();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: [
        Consumer<EventsNotifier>(
          builder: (context, provider, child) {
            final selectedEvents = widget.chat.events.where((element) => element.isSelected);
            final selection = selectedEvents.isNotEmpty;
            final listIcons = <Widget>[];
            if (selection) {
              listIcons.add(
                IconButton(
                  onPressed: () {
                    Provider.of<EventsNotifier>(context, listen: false)
                        .deleteEvents(widget.chat);
                  },
                  icon: Icon(selection ? Icons.delete : Icons.search),
                  color: bgColor,
                ),
              );
              listIcons.add(
                IconButton(
                  onPressed: () {
                    Provider.of<EventsNotifier>(context, listen: false)
                        .copySelected(widget.chat);
                  },
                  icon: const Icon(Icons.copy),
                  color: bgColor,
                ),
              );
              if (selectedEvents.length == 1) {
                listIcons.add(
                  IconButton(
                    onPressed: () {
                      _textEditingController.text =
                          widget.chat.events.where((element) => element.isSelected).first.text;
                      focusNode.requestFocus();
                      _edit = true;
                    },
                    icon: const Icon(Icons.edit),
                    color: bgColor,
                  ),
                );
              }
            }

            return Row(
              children: listIcons,
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            _favourites = !_favourites;
            setState(() {});
          },
          icon: Icon(favouritesIcon),
          color: favouritesColor,
        )
      ],
    );
  }
}
