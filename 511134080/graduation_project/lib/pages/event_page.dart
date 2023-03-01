import 'package:flutter/material.dart';
import 'package:graduation_project/entities/date_card.dart';
import 'package:intl/intl.dart';

import '../entities/event_card.dart';
import '../models/chat_model.dart';

class EventPage extends StatefulWidget {
  final String title;

  ChatModel chat;

  EventPage({
    required this.title,
    required this.chat,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final textFieldController = TextEditingController();

  void _clearTextInput() {
    textFieldController.clear();
  }

  Widget _returnEventsOrHintMessage(BuildContext context) {
    if (widget.chat.allCards.isNotEmpty) {
      return Expanded(
        flex: 10,
        child: ListView.builder(
          itemCount: widget.chat.allCards.length,
          reverse: true,
          itemBuilder: (context, index) {
            return widget.chat.allCards.reversed.elementAt(index);
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

  void _onEnterEvent(String title) {
    setState(() {
      var lastEvent = widget.chat.allCards.isEmpty
          ? null
          : widget.chat.allCards.last as EventCard;
      if (lastEvent == null ||
          DateFormat('dd-MM-yyyy').format(lastEvent.cardModel.time) !=
              DateFormat('dd-MM-yyyy').format(DateTime.now())) {
        widget.chat.allCards.add(
          DateCard(date: DateTime.now()),
        );
      }
      widget.chat.allCards.add(
        EventCard(
          title: title,
          time: DateTime.now(),
          key: UniqueKey(),
        ),
      );
      _clearTextInput();
    });
  }

  /*AppBar _createAppBar(BuildContext context) {
    Consumer<EventsProvider>(builder: (context, provider, child) {
      if (widget.chat.selectedCards.isEmpty) {
        return AppBar(
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
        );
      } else {
        return AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: Icon(
            Icons.close,
          ),
        );
      }
    });
  }*/

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
