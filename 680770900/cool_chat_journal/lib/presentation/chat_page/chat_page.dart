import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/event.dart';
import '../../data/models/category.dart';
import '../../data/models/chat.dart';
import '../../utils/custom_theme.dart';
import 'chat_cubit.dart';
import 'widgets/edit_mode_scaffold.dart';
import 'widgets/selected_mode_scaffold.dart';
import 'widgets/timeline_mode_scaffold.dart';
import 'widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final String? chatId;
  final String? chatName;
  final List<Chat> chats;

  const ChatPage({
    super.key,
    this.chatId,
    this.chatName,
    required this.chats,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  static final reverseDoubleTween = Tween<double>(begin: 1.0, end: 0.0);

  final _cubit = GetIt.I<ChatCubit>();

  late AnimationController _arrowAnimationController;

  void _onSearchEvents({
    required BuildContext context,
    required List<Event> events,
  }) async {
    await showSearch(
      context: context,
      delegate: EventSearchDelegate(
        events: events,
      ),
    );
  }

  Widget _eventsView({
    required List<Event> events,
    required List<Category> categories,
    required List<Event> selectedEvents,
    required bool isFavoriteMode,
  }) {
    if (events.isNotEmpty) {
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

          return Dismissible(
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(15.0),
              child: const Icon(Icons.edit),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(15.0),
              child: const Icon(Icons.delete),
            ),
            key: ValueKey<int>(viewIndex),
            child: EventView(
              chatName: widget.chatId == null
                  ? widget.chats
                      .firstWhere(
                        (chat) => chat.id == event.chatId,
                      )
                      .name
                  : null,
              event: event,
              category: category,
              isSelected: selectedEvents.contains(event),
              onTap: () {
                if (selectedEvents.isNotEmpty) {
                  _cubit.switchSelectStatus(event);
                } else {
                  _cubit.switchEventFavorite(event.id);
                }
              },
              onLongPress: () => _cubit.switchSelectStatus(event),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return true;
              } else {
                _cubit.switchSelectStatus(event);
                _cubit.addEditedEvent(event);

                return false;
              }
            },
            onDismissed: (_) => _cubit.deleteEvent(event),
          );
        },
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: Card(
          child: ListTile(
            title: Text(
              'This is the page where you can track '
              'everything about "${widget.chatName}"',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  BoxDecoration? _chatDecoration({
    required BuildContext context,
  }) {
    final backgroundImage = CustomTheme.of(context).backgroundImage;

    if (backgroundImage == null) return null;

    return BoxDecoration(
      image: DecorationImage(
        image: MemoryImage(backgroundImage),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _cubit.loadChat(widget.chatId);

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final sourceEvents = widget.chatId == null
            ? state.events
            : state.events.where((e) => e.chatId == widget.chatId).toList();

        final List<Event> events;
        if (state.isFavoriteMode) {
          final favorites = sourceEvents.where((e) => e.isFavorite).toList();
          events = favorites.isEmpty ? sourceEvents : favorites;
        } else {
          events = sourceEvents;
        }

        if (widget.chatId == null) {
          return TimelineModeScaffold(
            events: events,
            chats: widget.chats,
            categories: state.categories,
            isFavoriteMode: state.isFavoriteMode,
            chatDecoration: _chatDecoration(context: context),
            switchEventFavorite: _cubit.switchEventFavorite,
            onSearch: () => _onSearchEvents(
              context: context,
              events: events,
            ),
            onShowFavorites: _cubit.toggleFavoriteMode,
          );
        } else if (state.editedEvent != null) {
          return EditModeScaffold(
            events: events,
            editedEvent: state.editedEvent!,
            chatId: widget.chatId!,
            chats: widget.chats,
            categories: state.categories,
            chatDecoration: _chatDecoration(context: context),
            removeEditedEvent: _cubit.removeEditedEvent,
            resetSelection: _cubit.resetSelection,
          );
        } else if (state.selectedEvents.isNotEmpty) {
          return SelectedModeScaffold(
            events: events,
            selectedEvents: state.selectedEvents,
            chatId: widget.chatId!,
            chats: widget.chats,
            categories: state.categories,
            chatDecoration: _chatDecoration(context: context),
            resetSelection: _cubit.resetSelection,
            deleteSelectedEvents: _cubit.deleteSelectedEvents,
            copySelectedEvents: _cubit.copySelectedEvents,
            switchSelectedEventsFavorite: _cubit.switchSelectedEventsFavorite,
            transferSelectedEvents: _cubit.transferSelectedEvents,
            addEditedEvent: _cubit.addEditedEvent,
            switchSelectStatus: _cubit.switchSelectStatus,
          );
        }

        final Icon bookmarkIcon;
        if (state.isFavoriteMode) {
          bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
        } else {
          bookmarkIcon = const Icon(Icons.bookmark_border);
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: reverseDoubleTween.animate(_arrowAnimationController),
              ),
            ),
            title: Text(widget.chatName!),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _onSearchEvents(
                  context: context,
                  events: events,
                ),
              ),
              IconButton(
                icon: bookmarkIcon,
                onPressed: _cubit.toggleFavoriteMode,
              ),
            ],
          ),
          body: Container(
            decoration: _chatDecoration(context: context),
            child: Column(
              children: [
                Expanded(
                  child: _eventsView(
                    events: events,
                    categories: state.categories,
                    selectedEvents: state.selectedEvents,
                    isFavoriteMode: state.isFavoriteMode,
                  ),
                ),
                if (widget.chatId != null)
                  BottomPanel(
                    chatId: widget.chatId!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
