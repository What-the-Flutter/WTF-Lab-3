import 'package:flutter/material.dart';
import 'package:graduation_project/entities/date_card.dart';
import 'package:intl/intl.dart';

import '../entities/event_card.dart';

class EventPage extends StatefulWidget {
  final String title;

  EventPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  var _eventCards = <Widget>[];

  final textFieldController = TextEditingController();

  void clearTextInput() {
    textFieldController.clear();
  }

  Widget _returnEventsOrHintMessage(BuildContext context) {
    if (_eventCards.isNotEmpty) {
      return Expanded(
        flex: 10,
        child: ListView.builder(
          itemCount: _eventCards.length,
          reverse: true,
          itemBuilder: (context, index) {
            return _eventCards.reversed.elementAt(index);
          },
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
              'This is the page where you can track everything about "${widget.title}!"\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Add your first event to "${widget.title}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
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

  void OnEnterEvent(String title) {
    setState(() {
      var lastEvent =
          _eventCards.isEmpty ? null : _eventCards.last as EventCard;
      if (lastEvent == null ||
          DateFormat('dd-MM-yyyy').format(lastEvent.time) !=
              DateFormat('dd-MM-yyyy').format(DateTime.now())) {
        _eventCards.add(
          DateCard(date: DateTime.now()),
        );
      }
      _eventCards.add(
        EventCard(
          title: title,
          time: DateTime.now(),
        ),
      );
      clearTextInput();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.title,
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
            icon: const Icon(Icons.bookmark_border_outlined),
            onPressed: () {},
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          _returnEventsOrHintMessage(context),
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
                          controller: textFieldController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter event',
                            filled: true,
                            fillColor:
                                Theme.of(context).disabledColor.withAlpha(24),
                          ),
                          onSubmitted: (String? value) {
                            if (value != '') {
                              OnEnterEvent(value!);
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
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
