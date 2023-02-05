import 'package:flutter/material.dart';

import '../../model/event.dart';
import '../../model/events_group.dart';
import 'app_bar_builder.dart';
import 'bottom_panel.dart';
import 'delete_dialog.dart';
import 'event_view.dart';

class EventsPage extends StatefulWidget {  

  final EventsGroup eventsGroup;

  const EventsPage(this.eventsGroup);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  final Map<int, bool> _selectedFlag = {};
  
  AppBarBuilder? _appBarBuilder;

  bool _showFavorites = false;
  bool _isEditMode = false;

  bool isSelectionMode() => countSelectedEvents() != 0;

  void addEvent(String eventText) {
    setState(() {
      widget.eventsGroup.events.add(Event(eventText));
    });
  }

  void editEvent(String eventText) {
    var index = _selectedFlag.keys.
      firstWhere((i) => _selectedFlag[i] == true);

    setState(() {
      widget.eventsGroup.events[index].text = eventText;
    });

    _isEditMode = false;
    handleResetSelection();
  }

  void handleTap(bool isSelected, int index) {
    if (isSelectionMode()) {
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
    });
  }

  void handleResetSelection() {
    setState(() {
      for (final i in _selectedFlag.keys) {
        _selectedFlag[i] = false;
      }
    });
  }

  void handleRemoval() {
    showModalBottomSheet<bool>(
      context: context,
      builder: (context) => DeleteDialog(countSelectedEvents()),  
    ).then((value) {
      if (value == true) {
        var events = widget.eventsGroup.events;
        for (var i = 0; i < widget.eventsGroup.count; i++) {
          if (_selectedFlag[i] == true) {
            events.remove(events[i]);
          }
        }
      }
    }).then(
      (value) => handleResetSelection()
    );
  }

  void handleBackButton() {
    Navigator.pop(context);
  }

  void handleShowFavorite() {
    setState(() => _showFavorites = !_showFavorites);
  }

  void handleMarkFavorites() {
    var events = widget.eventsGroup.events;
    for (var i = 0; i < widget.eventsGroup.count; i++) {
      if (_selectedFlag[i] == true) {
        events[i].isFavorite = !events[i].isFavorite;
      }
    }
    handleResetSelection();
  }

  void handleEditAction() {
    setState(() {
      _isEditMode = true;
    });
  }

  void handleCloseEditMode() {
    setState(() {
      _isEditMode = false;
    });

    handleResetSelection();

  }

  int countSelectedEvents() {
    return _selectedFlag.values.where((value) => value).length;
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
    var index = _selectedFlag.keys.
      firstWhere((i) => _selectedFlag[i] == true, orElse: () => -1);

    return Column(
      children: [
        Expanded(
          child: buildEventsView(),
        ),

        if (!isSelectionMode())
          BottomPanel(
            onSendText: addEvent,
          ),

        if (_isEditMode && index != -1)
          BottomPanel(
            textFieldValue: widget.eventsGroup.events[index].text,
            onSendText: editEvent,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    _appBarBuilder ??= AppBarBuilder(
      title: widget.eventsGroup.groupName,
      handleBackButton: handleBackButton,
      handleResetSelection: handleResetSelection,
      handleShowFavorite: handleShowFavorite,
      handleRemoval: handleRemoval,
      handleMarkFavorites: handleMarkFavorites,
      handleEditAction: handleEditAction,
      handleCloseEditMode: handleCloseEditMode,
    );

    return Scaffold(
      appBar: _appBarBuilder!.build(
        countSelected: countSelectedEvents(),
        showFavorites: _showFavorites,
        isEditMode: _isEditMode
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