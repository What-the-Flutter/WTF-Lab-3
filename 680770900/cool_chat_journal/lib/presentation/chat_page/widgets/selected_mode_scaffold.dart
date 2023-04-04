import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import 'dialogs.dart';
import 'event_view.dart';

class SelectedModeScaffold extends StatelessWidget {
  final List<Event> events;
  final List<Event> selectedEvents;
  final String chatId;
  final List<Chat> chats;
  final List<Category> categories;
  final BoxDecoration? chatDecoration;
  final Function() resetSelection;
  final Function() deleteSelectedEvents;
  final Function() copySelectedEvents;
  final Function() switchSelectedEventsFavorite;
  final Function(String) transferSelectedEvents;
  final Function(Event) addEditedEvent;
  final Function(Event) switchSelectStatus;

  const SelectedModeScaffold({
    super.key,
    required this.events,
    required this.selectedEvents,
    required this.chatId,
    required this.chats,
    required this.categories,
    required this.resetSelection,
    required this.deleteSelectedEvents,
    required this.copySelectedEvents,
    required this.switchSelectedEventsFavorite,
    required this.transferSelectedEvents,
    required this.addEditedEvent,
    required this.switchSelectStatus,
    this.chatDecoration,
  });

  void _onTransferEvents({
    required BuildContext context,
  }) async {
    final destinationChat = await showDialog<String>(
      context: context,
      builder: (_) => TransferDialog(
        chats: chats.where((chat) => chat.id != chatId).toList(),
      ),
    );

    if (destinationChat != null) {
      transferSelectedEvents(destinationChat);
    }

    resetSelection();
  }

  void _onDeleteEvents({
    required BuildContext context,
  }) async {
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => DeleteDialog(countSelectedEvents: selectedEvents.length),
    );

    if (value == true) {
      deleteSelectedEvents();
    }

    resetSelection();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = selectedEvents.where((e) => e.image != null).isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: resetSelection,
        ),
        title: Text(selectedEvents.length.toString()),
        actions: [
          IconButton(
            icon: const Icon(Icons.reply),
            onPressed: () => _onTransferEvents(context: context),
          ),
          if (!hasImage && selectedEvents.length == 1)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => addEditedEvent(selectedEvents.first),
            ),
          if (!hasImage)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                copySelectedEvents();
                resetSelection();
              },
            ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              switchSelectedEventsFavorite();
              resetSelection();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _onDeleteEvents(context: context),
          ),
        ],
      ),
      body: Container(
        decoration: chatDecoration,
        child: _EventsView(
          events: events,
          selectedEvents: selectedEvents,
          chats: chats,
          categories: categories,
          switchSelectStatus: switchSelectStatus,
        ),
      ),
    );
  }
}

class _EventsView extends StatelessWidget {
  final List<Event> events;
  final List<Event> selectedEvents;
  final List<Chat> chats;
  final List<Category> categories;
  final Function(Event) switchSelectStatus;

  const _EventsView({
    super.key,
    required this.events,
    required this.selectedEvents,
    required this.chats,
    required this.categories,
    required this.switchSelectStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: events.length,
        itemBuilder: (_, index) {
          final viewIndex = events.length - index - 1;
          final event = events[viewIndex];

          final Category? category;
          if (event.categoryId != null) {
            category = categories.firstWhere((e) => e.id == event.categoryId);
          } else {
            category = null;
          }

          return EventView(
            event: event,
            category: category,
            isSelected: selectedEvents.contains(event),
            onTap: () => switchSelectStatus(event),
            onLongPress: () => switchSelectStatus(event),
          );
        });
  }
}
