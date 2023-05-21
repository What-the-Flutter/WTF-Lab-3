import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../widgets/date_widget.dart';
import '../widgets/event_widget.dart';

class SearchPage extends StatefulWidget {
  final Chat chat;

  SearchPage({super.key, required this.chat});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Widget _showMessages(BuildContext context) {
    final findMessages = RegExp(_textController.text);
    var isMatch = false;
    var foundMessages = <Event>[];
    for (var event in widget.chat.events) {
      if (findMessages.hasMatch(event.text)) {
        isMatch = true;
        foundMessages.add(event);
      }
    }
    if (isMatch && _textController.text.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => _eventTile(index, foundMessages),
        reverse: true,
        itemCount: foundMessages.length,
      );
    }
    return _getHint(context);
  }

  Widget _eventTile(index, foundMessages) {
    final events = foundMessages.reversed;
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

  Column _getHint(BuildContext context) {
    final hint = _textController.text.isEmpty
        ? Column(
            children: [
              const Icon(
                Icons.search,
                size: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter a search query to begin searching',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          )
        : Column(
            children: [
              const Text(
                'No search results available',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'No entries match the given search query. Please, try again',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          );
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: hint,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Search in '${widget.chat.name}'",
            ),
            focusNode: focusNode,
            autofocus: true,
            onChanged: (input) {
              setState(() {});
            }),
      ),
      body: _showMessages(context),
    );
  }
}
