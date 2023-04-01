import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../presentation.dart';
import 'dialogs.dart';
import 'event_view.dart';

class SelectedModeScaffold extends StatelessWidget {
  final List<Event> events;
  final List<Event> selectedEvents;
  final String chatId;
  final List<Chat> chats;
  final List<Category> categories;
  final BoxDecoration? chatDecoration;
  final ChatCubit cubit;
  
  const SelectedModeScaffold({
    super.key,
    required this.events,
    required this.selectedEvents,
    required this.chatId,
    required this.chats,
    required this.categories,
    required this.cubit,
    this.chatDecoration,
  });

  void _onTransferEvents({
    required BuildContext context,
  }) async {
    final destinationChat = await showDialog<String>(
      context: context,
      builder: (_) => 
        TransferDialog(
          chats: chats.where((chat) => chat.id != chatId).toList(),
        ),
    );

    if (destinationChat != null) {
      cubit.transferSelectedEvents(destinationChat);
    }

    cubit.resetSelection();
  }

  void _onDeleteEvents({
    required BuildContext context,
  }) async {
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => DeleteDialog(countSelectedEvents: selectedEvents.length),
    );

    if (value == true) {
      cubit.deleteSelectedEvents();
    }

    cubit.resetSelection();
  }
  
  @override
  Widget build(BuildContext context) {
    final hasImage = selectedEvents.where((e) => e.image != null).isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: cubit.resetSelection,
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
              onPressed: () => cubit.addEditedEvent(selectedEvents.first),
            ),
          if (!hasImage)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                cubit.copySelectedEvents();
                cubit.resetSelection();
              },
            ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              cubit.switchSelectedEventsFavorite();
              cubit.resetSelection();
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
          cubit: cubit,
          events: events,
          selectedEvents: selectedEvents,
          chats: chats,
          categories: categories,
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
  final ChatCubit cubit;

  const _EventsView({
    super.key,
    required this.events,
    required this.selectedEvents,
    required this.chats,
    required this.categories,
    required this.cubit,
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
          category = categories
              .firstWhere((e) => e.id == event.categoryId);
        } else {
          category = null;
        }

        return EventView(
          event: event,
          category: category,
          isSelected: selectedEvents.contains(event),
          onTap: () => cubit.switchSelectStatus(event),
          onLongPress: () => cubit.switchSelectStatus(event),
        );
      }
    );
  }
}