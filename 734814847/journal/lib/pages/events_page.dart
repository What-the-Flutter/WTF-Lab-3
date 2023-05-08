import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../EventNotifier.dart';
import '../models/chat.dart';
import '../widgets/date_widget.dart';
import '../widgets/event_widget.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key, required this.chat});

  Chat chat;
  bool selection = false;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Widget _showMessages(BuildContext context) {
    var events = widget.chat.events;
    if (events.isEmpty) {
      return _getHint(context);
    } else {
      return Expanded(
        flex: 8,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return events.reversed.elementAt(index);
          },
          reverse: true,
          itemCount: widget.chat.events.length,
        ),
      );
    }
  }

  Container _getHint(BuildContext context) {
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
  }

  void _addMessage(BuildContext context, String text) {
    setState(() {
      var prevEvent = widget.chat.events.isEmpty
          ? null
          : widget.chat.events.last as EventWidget;
      if (prevEvent == null ||
          DateFormat.yMMMMd('en_US').format(prevEvent.event.date) !=
              DateFormat.yMMMMd('en_US').format(DateTime.now())) {
        widget.chat.events.add(Date(date: DateTime.now()));
      }
      widget.chat.events.add(EventWidget(text: text, date: DateTime.now()));
      _textEditingController.clear();
    });
  }

  void _deleteMessage (BuildContext context) {
    Provider.of<EventsNotifier>(context, listen: false).deleteEvents(widget.chat);
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

    var selectionInterface = widget.selection ? Icons.delete : Icons.search;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
        centerTitle: true,
        actions: [
          Consumer<EventsNotifier>(
            builder: (context, provider, child) {
              var selection = provider.selectionChatHandler(widget.chat);
              var selectionInterface = selection ? Icons.delete : Icons.search;
              return IconButton(
                  onPressed: () {
                    if (selection) {
                      _deleteMessage(context);
                      setState(() {});
                    }
                  },
                  icon: Icon(selectionInterface),
                  color: bgColor);
            },
          ),
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
