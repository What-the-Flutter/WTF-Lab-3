import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/functions.dart';

import '../../../data/models/models.dart';
import '../../filters_page/filters_cubit.dart';
import '../../filters_page/filters_page.dart';
import 'widgets.dart';

class TimelineModeScaffold extends StatelessWidget {
  final List<Event> events;
  final List<Chat> chats;
  final List<Category> categories;
  final BoxDecoration? chatDecoration;
  final bool isFavoriteMode;
  final Function(String) switchEventFavorite;
  final Function()? onShowFavorites;
  final Function()? onSearch;

  const TimelineModeScaffold({
    super.key,
    required this.events,
    required this.chats,
    required this.categories,
    required this.isFavoriteMode,
    required this.switchEventFavorite,
    this.chatDecoration,
    this.onShowFavorites,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final Icon bookmarkIcon;
    if (isFavoriteMode) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Timeline'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearch?.call,
            ),
            IconButton(
              icon: bookmarkIcon,
              onPressed: onShowFavorites?.call,
            ),
          ]),
      body: Container(
        decoration: chatDecoration,
        child: Column(
          children: [
            Expanded(
              child: _EventsView(
                events: events,
                chats: chats,
                categories: categories,
                switchEventFavorite: switchEventFavorite,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.filter_list),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FiltersPage(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Timeline',
          ),
        ],
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class _EventsView extends StatelessWidget {
  final List<Event> events;
  final List<Chat> chats;
  final List<Category> categories;
  final Function(String) switchEventFavorite;

  const _EventsView({
    super.key,
    required this.events,
    required this.chats,
    required this.categories,
    required this.switchEventFavorite,
  });

  List<Event> _chatsFilteredEvents({
    required List<Event> events,
    required List<String> chatsId,
    required bool ignoreChats,
  }) {
    if (!ignoreChats) {
      return chatsId.isNotEmpty
          ? events.where((e) => chatsId.contains(e.chatId)).toList()
          : events;
    } else {
      return events.where((e) => chatsId.contains(e.chatId)).toList();
    }
  }

  List<Event> _categoriesFilteredEvents({
    required List<Event> events,
    required List<String> categoriesId,
  }) {
    return categoriesId.isNotEmpty
        ? events.where((e) => categoriesId.contains(e.categoryId)).toList()
        : events;
  }

  List<Event> _tagsFilteredEvents({
    required List<Event> events,
    required List<String> tags,
  }) {
    return tags.isEmpty
        ? events
        : events.where(
            (e) {
              if (e.content == null) return false;

              final eventTags = extractHashTags(e.content!);

              for (final tag in tags) {
                if (eventTags.contains('#$tag')) return true;
              }

              return false;
            },
          ).toList();
  }

  List<String> _filter({
    required List<String> elements,
    required List<String> selected,
    bool? ignoreSelected,
  }) {
    if (elements.isEmpty) return [];

    if (ignoreSelected == null || !ignoreSelected) {
      return selected.toList();
    } else {
      return elements.where((e) => !selected.contains(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      builder: (_, state) {
        final chatFilter = _filter(
          elements: state.chats.map((chat) => chat.id).toList(),
          selected: state.selectedChats.map((chat) => chat.id).toList(),
          ignoreSelected: state.ignoreSelected,
        );

        final tagFilter = _filter(
          elements: state.tags.map((tag) => tag.id).toList(),
          selected: state.selectedTags.map((tag) => tag.id).toList(),
        );

        final categoryFilter = _filter(
          elements: state.categories.map((category) => category.id).toList(),
          selected:
              state.selectedCategories.map((category) => category.id).toList(),
        );

        final filteredEvents = _tagsFilteredEvents(
            tags: tagFilter,
            events: _categoriesFilteredEvents(
              categoriesId: categoryFilter,
              events: _chatsFilteredEvents(
                events: events,
                chatsId: chatFilter,
                ignoreChats: state.ignoreSelected,
              ),
            ));

        if (filteredEvents.isEmpty) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: ListTile(
                title: Text(
                  'There are no events to be displayed on your timeline, '
                  'or you have filtered out all your pages in the filter menu.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return ListView.builder(
            reverse: true,
            itemCount: filteredEvents.length,
            itemBuilder: (_, index) {
              final viewIndex = filteredEvents.length - index - 1;
              final event = filteredEvents[viewIndex];

              final Category? category;
              if (event.categoryId != null) {
                category =
                    categories.firstWhere((e) => e.id == event.categoryId);
              } else {
                category = null;
              }

              return EventView(
                chatName:
                    chats.firstWhere((chat) => chat.id == event.chatId).name,
                event: event,
                category: category,
                onTap: () => switchEventFavorite(event.id),
              );
            });
      },
    );
  }
}
