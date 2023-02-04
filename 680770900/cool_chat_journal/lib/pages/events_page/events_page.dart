import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/event.dart';
import '../../model/events_group.dart';
import 'bottom_panel.dart';
import 'event_view.dart';

class EventsPage extends StatefulWidget {  

  final EventsGroup eventsGroup;

  const EventsPage(this.eventsGroup);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  bool _isSelectedMode = false;
  final Map<int, bool> _selectedFlag = {};

  bool _showFavorites = false;

  void addEvent(String eventText) {
    setState(() {
      widget.eventsGroup.events.add(Event(eventText));
    });
  }

  void handleTap(bool isSelected, int index) {
    if (_isSelectedMode) {
       handleLongPress(isSelected, index);
    } else {
      setState(() {
        var event = widget.eventsGroup.events[index];
        event.isFavorite = !event.isFavorite;
      });
    }
  }

  void handleLongPress(bool isSelected, int index) {
    setState(() {
      _selectedFlag[index] = !isSelected;
      _isSelectedMode = _selectedFlag.containsValue(true);
    });
  }

  void resetSelection() {
    setState(() {
      for (final i in _selectedFlag.keys) {
        _selectedFlag[i] = false;
      }
      _isSelectedMode = false;
    });
  }

  int countSelectedEvents() {
    return _selectedFlag.values.where((value) => value).length;
  }

  Widget buildAppBarLeading() {
    if (!_isSelectedMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: resetSelection,
      );
    }
  }

  Widget buildAppBarTitle() {
    if (!_isSelectedMode) {
      return Text(widget.eventsGroup.groupName);
    } else {
      var count = countSelectedEvents();
      return Text(count.toString());
    }
  }

  List<Widget> buildActions() {
    var actions = <Widget>[];

    if (!_isSelectedMode) {
      actions.add(buildSearchAction());
      actions.add(buildFavoriteAction());
    } else {
      if (countSelectedEvents() == 1) {
        actions.add(buildEditAction());
      }
      actions.add(buildCopyAction());
      actions.add(buildMarkFavoriteAction());
      actions.add(buildDeleteAction());
    }

    return actions;
  }

  Widget buildFavoriteAction() {
    Icon bookmarkIcon;
    if (_showFavorites) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return IconButton(
      icon: bookmarkIcon,
      onPressed: () {
        setState(() => _showFavorites = !_showFavorites);
      },
    );
  }

  Widget buildSearchAction() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => {},
    );
  }

  Widget buildDeleteAction() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showModalBottomSheet<bool>(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delete Entry(s)?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    'Are you sure you want delete the '
                    '${countSelectedEvents()} selected events?',
                  ),
                  
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context, true),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: const Text('Delete'),
                  ),

                  TextButton.icon(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.blue,
                    ),
                    label: const Text('Cancel'),
                  ),
                ],
              ),
            );
          },  
        ).then((value) {
          if (value == true) {
            var events = widget.eventsGroup.events;
            for (var i = 0; i < widget.eventsGroup.count; i++) {
              if (_selectedFlag[i] == true) {
                events.remove(events[i]);
              }
            }
            resetSelection();
          }
        });
      },
    );
  }

  Widget buildCopyAction() {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: resetSelection,
    );
  }

  Widget buildMarkFavoriteAction() {
    return IconButton(
      icon: const Icon(Icons.bookmark_border),
      onPressed: () {
        for (var i = 0; i < widget.eventsGroup.count; i++) {
          if (_selectedFlag[i] == true) {
            var event = widget.eventsGroup.events[i];
            event.isFavorite = !event.isFavorite;
          }
        }

        resetSelection();
      },
    );
  }

  Widget buildEditAction() {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: resetSelection,
    );
  }

  Widget buildEventsView() {
    if (widget.eventsGroup.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.eventsGroup.count,
        itemBuilder: (_, index) {
          _selectedFlag[index] = _selectedFlag[index] ?? false;  
          var isSelected = _selectedFlag[index]!;

          return EventView(
            event: widget.eventsGroup.events[index],
            isSelected: isSelected,
            onTap: () => handleTap(isSelected, index),
            onLongPress: () => handleLongPress(isSelected, index),
          );
        }
      ); 
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: _WelcomeMessage(title: widget.eventsGroup.groupName),
      );
    }
  }

  Widget buildScaffoldBody() {
    return Column(
      children: [
        Expanded(
          child: buildEventsView(),
        ),

        if (!_isSelectedMode)
          BottomPanel(
            onSendText: addEvent,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buildAppBarLeading(),
        title: buildAppBarTitle(),
        actions: buildActions(),
      ),
      body: buildScaffoldBody(),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  
  final String title;

  const _WelcomeMessage({required this.title});
  
  @override
  Widget build(BuildContext context) {
    var titleMessage = 'This is the page where you can track '
      'everything about "$title"';

    return Card(
      child: ListTile(
        title: Text(
          titleMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}