import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/event.dart';
import '../../data/models/category.dart';
import '../home_page/home_cubit.dart';
import '../settings_page/settings_cubit.dart';
import 'chat_cubit.dart';
import 'widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatPage({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late VoidCallback _unsubscribeEventsStream;

  bool _isHasImage(BuildContext context) {
    return GetIt.I<ChatCubit>()
        .state
        .events
        .where(
          (event) =>
              GetIt.I<ChatCubit>().state.selectedEventsIds.contains(event.id) &&
              event.image != null,
        )
        .isNotEmpty;
  }

  void _searchEvents(BuildContext context) async {
    await showSearch(
      context: context,
      delegate: EventSearchDelegate(
        events: GetIt.I<ChatCubit>().state.events,
      ),
    );
  }

  void _transferEvents(BuildContext context) async {
    final destinationChat = await showDialog<String>(
      context: context,
      builder: (context) => TransferDialog(
          chats: GetIt.I<HomeCubit>()
              .state
              .chats
              .where(
                (chat) => chat.id != widget.chatId,
              )
              .toList()),
    );
    if (destinationChat != null) {
      GetIt.I<ChatCubit>().transferSelectedEvents(destinationChat);
    }

    GetIt.I<ChatCubit>().resetSelection();
  }

  void _deleteEvents(BuildContext context) async {
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => DeleteDialog(
        GetIt.I<ChatCubit>().state.selectedEventsIds.length,
      ),
    );

    if (value == true) {
      GetIt.I<ChatCubit>().deleteSelectedEvents();
    }

    GetIt.I<ChatCubit>().resetSelection();
  }

  Widget _createAppBarLeading(BuildContext context) {
    if (GetIt.I<ChatCubit>().state.selectedEventsIds.isEmpty) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    } else if (GetIt.I<ChatCubit>().state.isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: GetIt.I<ChatCubit>().toggleEditMode,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: GetIt.I<ChatCubit>().resetSelection,
      );
    }
  }

  Widget _createAppBarTitle(BuildContext context) {
    final selectedEvents = GetIt.I<ChatCubit>().state.selectedEventsIds;
    if (selectedEvents.isEmpty) {
      return Text(widget.chatName);
    } else if (GetIt.I<ChatCubit>().state.isEditMode) {
      return const Text('Edit mode');
    } else {
      return Text(selectedEvents.length.toString());
    }
  }

  List<Widget> _createActions(BuildContext context) {
    if (GetIt.I<ChatCubit>().state.selectedEventsIds.isEmpty) {
      return _createActionsForNotSelectionMode(context);
    } else if (GetIt.I<ChatCubit>().state.isEditMode) {
      return _createActionsForEditMode(context);
    } else {
      return _createActionsForSelectionMode(context);
    }
  }

  List<Widget> _createActionsForNotSelectionMode(BuildContext context) {
    final Icon bookmarkIcon;
    if (GetIt.I<ChatCubit>().state.isFavoriteMode) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => _searchEvents(context),
      ),
      IconButton(
        icon: bookmarkIcon,
        onPressed: GetIt.I<ChatCubit>().toggleFavoriteMode,
      ),
    ];
  }

  List<Widget> _createActionsForEditMode(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: context.read<ChatCubit>().toggleEditMode,
      ),
    ];
  }

  List<Widget> _createActionsForSelectionMode(BuildContext context) {
    final selectedEventsCount =
        GetIt.I<ChatCubit>().state.selectedEventsIds.length;
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () => _transferEvents(context),
      ),
      if (!_isHasImage(context) && selectedEventsCount == 1)
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: GetIt.I<ChatCubit>().toggleEditMode,
        ),
      if (!_isHasImage(context))
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            GetIt.I<ChatCubit>().copySelectedEvents();
            GetIt.I<ChatCubit>().resetSelection();
          },
        ),
      IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: () {
          GetIt.I<ChatCubit>().switchSelectedEventsFavorite();
          GetIt.I<ChatCubit>().resetSelection();
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteEvents(context),
      ),
    ];
  }

  Widget _createScaffoldBody(BuildContext context) {
    final selectedEvents = GetIt.I<ChatCubit>().state.selectedEventsIds;
    final Event? selectedEvent;
    if (selectedEvents.length != 1) {
      selectedEvent = null;
    } else {
      selectedEvent = GetIt.I<ChatCubit>().state.events.firstWhere(
            (event) => selectedEvents.contains(event.id),
          );
    }

    return Column(
      children: [
        Expanded(
          child: _createEventsView(),
        ),
        BottomPanel(
          chatId: widget.chatId,
          sourceEvent: selectedEvent,
        ),
      ],
    );
  }

  List<Event> _generateEventsList(ChatState state) {
    final events = state.events;
    final List<Event> favorites;
    if (state.isFavoriteMode) {
      favorites = events.where((event) => event.isFavorite).toList();

      if (favorites.isNotEmpty) return favorites;
    }

    return events;
  }

  Widget _createEventsView() {
    final events = _generateEventsList(GetIt.I<ChatCubit>().state);

    if (events.isNotEmpty) {
      return ListView.builder(
          reverse: true,
          itemCount: events.length,
          itemBuilder: (_, index) {
            final viewIndex = events.length - index - 1;
            final event = events[viewIndex];

            final Category? category;
            if (event.categoryId != null) {
              category = GetIt.I<ChatCubit>()
                  .state
                  .categories
                  .firstWhere((e) => e.id == event.categoryId);
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
                event: event,
                category: category,
                isSelected: GetIt.I<ChatCubit>()
                    .state
                    .selectedEventsIds
                    .contains(event.id),
                onTap: () {
                  if (GetIt.I<ChatCubit>().state.selectedEventsIds.isNotEmpty) {
                    GetIt.I<ChatCubit>().switchSelectStatus(event.id);
                  } else {
                    GetIt.I<ChatCubit>().switchEventFavorite(event.id);
                  }
                },
                onLongPress: () =>
                    GetIt.I<ChatCubit>().switchSelectStatus(event.id),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  return true;
                } else if (!GetIt.I<ChatCubit>().state.isEditMode) {
                  GetIt.I<ChatCubit>().switchSelectStatus(widget.chatId);
                  GetIt.I<ChatCubit>().toggleEditMode();
                }

                return false;
              },
              onDismissed: (_) => GetIt.I<ChatCubit>().deleteEvent(event),
            );
          });
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

  @override
  void initState() {
    super.initState();

    GetIt.I<ChatCubit>().loadChat(widget.chatId);
    GetIt.I<ChatCubit>().subscribeStreams();
    _unsubscribeEventsStream = GetIt.I<ChatCubit>().unsubscribeStreams;
  }

  @override
  void dispose() {
    _unsubscribeEventsStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final body = _createScaffoldBody(context);

        final backgroundImage = GetIt.I<SettingsCubit>().state.backgroundImage;
        final BoxDecoration? boxDecoration;
        if (backgroundImage != null) {
          boxDecoration = BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          );
        } else {
          boxDecoration = null;
        }

        return Scaffold(
          appBar: AppBar(
            leading: _createAppBarLeading(context),
            title: _createAppBarTitle(context),
            actions: _createActions(context),
          ),
          body: Container(
            decoration: boxDecoration,
            child: body,
          ),
        );
      },
    );
  }
}
