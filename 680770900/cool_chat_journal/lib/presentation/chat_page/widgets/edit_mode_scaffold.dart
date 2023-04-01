import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../presentation.dart';
import 'bottom_panel.dart';
import 'event_view.dart';

class EditModeScaffold extends StatelessWidget {
  final List<Event> events;
  final Event editedEvent;
  final String chatId;
  final List<Chat> chats;
  final List<Category> categories;
  final BoxDecoration? chatDecoration;
  final ChatCubit cubit;
  
  const EditModeScaffold({
    super.key,
    required this.events,
    required this.editedEvent,
    required this.chatId,
    required this.chats,
    required this.categories,
    required this.cubit,
    this.chatDecoration,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            cubit.removeEditedEvent();
            cubit.resetSelection();
          },
        ),
        title: const Text('Edit mode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              cubit.removeEditedEvent();
              cubit.resetSelection();
            },
          ),
        ]
      ),
      body: Container(
        decoration: chatDecoration,
        child: Column(
          children: [
            Expanded(
              child: _EventsView(
                cubit: cubit,
                events: events,
                chats: chats,
                categories: categories,
              ),
            ),
            BottomPanel(
              chatId: chatId,
              sourceEvent: editedEvent,
            ),
          ],
        ),
      ),
    );
  }
}

class _EventsView extends StatelessWidget {
  final List<Event> events;
  final List<Chat> chats;
  final List<Category> categories;
  final ChatCubit cubit;

  const _EventsView({
    super.key,
    required this.events,
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
        );
      }
    );
  }
}