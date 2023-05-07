import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';
import '../widgets/date_widget.dart';
import '../widgets/event_widget.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key, required this.chat});

  //final String title;
  Chat chat;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _textEditingController = TextEditingController();

  Widget _showMessages(BuildContext context) {
    var events = widget.chat.events;
    if (events.isEmpty) {
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
              'Add your first event to "${widget.chat.name}" page by entering'
              ' some text in the box below and hitting the send button.'
              'Long tap the send button to align the event in the opposite'
              ' direction. Tap on the bookmark icon on the top right corner'
              ' to show the bookmarked events only.',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        flex: 8,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return events.reversed.elementAt(index);
          },
          reverse: true,
          itemCount: widget.chat.events.length ?? 0,
        ),
      );
    }
  }

  void _addMessage(BuildContext context, String text) {
    setState(() {
      var prevEvent =
          widget.chat.events.isEmpty ? null : widget.chat.events.last as Event;
      if (prevEvent == null ||
          DateFormat.yMMMMd('en_US').format(prevEvent.date) !=
              DateFormat.yMMMMd('en_US').format(DateTime.now())) {
        widget.chat.events.add(Date(date: DateTime.now()));
      }
      widget.chat.events.add(Event(text: text, date: DateTime.now()));
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    final bgColor = theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.search), color: bgColor),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
              color: bgColor)
        ],
      ),
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
                    )),
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
  }
}
