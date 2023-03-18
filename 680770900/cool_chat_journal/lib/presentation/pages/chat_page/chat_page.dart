import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/event.dart';
import '../home_page/home_cubit.dart';
import 'chat_cubit.dart';
import 'widgets/bottom_panel.dart';
import 'widgets/dialogs.dart';
import 'widgets/event_search_delegate.dart';
import 'widgets/event_view.dart';

class ChatPage extends StatelessWidget {
  final String chatId;
  final String chatName;

  const ChatPage._({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  static Route<void> route({
    Key? key,
    required HomeCubit homeCubit,
    required String chatId,
    required String chatName,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: homeCubit,
        child: ChatPage._(
          key: key,
          chatId: chatId,
          chatName: chatName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: ChatView(
        chatId: chatId,
        chatName: chatName,
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatView({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

   bool _isHasImage(BuildContext context) {
    final state = context.read<ChatCubit>().state;

    return state.events
        .where(
          (event) => 
            state.selectedEventsIds.contains(event.id) && event.isImage,
        )
        .isNotEmpty;
  }

  void _searchEvents(BuildContext context) async {
    await showSearch(
      context: context,
      delegate: EventSearchDelegate(
        events: context.read<ChatCubit>().state.events,
      ),
    );
  }

  void _transferEvents(BuildContext context) async {
    final homeCubit = context.read<HomeCubit>();
    final chatCubit = context.read<ChatCubit>();

    final destinationChat = await showDialog<String>(
      context: context,
      builder: (context) => TransferDialog(
          chats: homeCubit.state.chats
              .where(
                (chat) => chat.id != widget.chatId,
              )
              .toList()),
    );
    if (destinationChat != null) {
      chatCubit.transferSelectedEvents(destinationChat);
    }

    chatCubit.resetSelection();
  }

  void _deleteEvents(BuildContext context) async {
    final cubit = context.read<ChatCubit>();
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) =>
          DeleteDialog(cubit.state.selectedEventsIds.length),
    );

    if (value == true) {
      cubit.deleteSelectedEvents();
    }

    cubit.resetSelection();
  }

  Widget _createAppBarLeading(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    final chatState = chatCubit.state;
    if (chatState.selectedEventsIds.isEmpty) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    } else if (chatState.isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: chatCubit.toggleEditMode,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: chatCubit.resetSelection,
      );
    }
  }

  Widget _createAppBarTitle(BuildContext context) {
    final chatState = context.read<ChatCubit>().state;
    final selectedEvents = chatState.selectedEventsIds;
    if (selectedEvents.isEmpty) {
      return Text(widget.chatName);
    } else if (chatState.isEditMode) {
      return const Text('Edit mode');
    } else {
      return Text(selectedEvents.length.toString());
    }
  }

  List<Widget> _createActions(BuildContext context) {
    final chatState = context.read<ChatCubit>().state;
    if (chatState.selectedEventsIds.isEmpty) {
      return _createActionsForNotSelectionMode(context);
    } else if (chatState.isEditMode) {
      return _createActionsForEditMode(context);
    } else {
      return _createActionsForSelectionMode(context);
    }
  }

  List<Widget> _createActionsForNotSelectionMode(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();

    final Icon bookmarkIcon;
    if (chatCubit.state.isFavoriteMode) {
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
        onPressed: chatCubit.toggleFavoriteMode,
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
    final cubit = context.read<ChatCubit>();

    final selectedEventsCount = cubit.state.selectedEventsIds.length;
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () => _transferEvents(context),
      ),
      if (!_isHasImage(context) && selectedEventsCount == 1)
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: cubit.toggleEditMode,
        ),
      if (!_isHasImage(context))
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
        onPressed: () => _deleteEvents(context),
      ),
    ];
  }

  Widget _createScaffoldBody(BuildContext context) {
    final chatState = context.read<ChatCubit>().state;
    final selectedEvents = chatState.selectedEventsIds;
    final Event? selectedEvent;
    if (selectedEvents.length != 1) {
      selectedEvent = null;
    } else {
      selectedEvent = chatState.events.firstWhere(
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
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          previous.events != current.events,
      listener: (context, state) {
        context.read<HomeCubit>().updateChats();
      },
      builder: (context, state) {
        final events = _generateEventsList(state);

        if (events.isNotEmpty) {
          final cubit = context.read<ChatCubit>();

          return ListView.builder(
              reverse: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final viewIndex = events.length - index - 1;
                final event = events[viewIndex];

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
                    isSelected:
                        cubit.state.selectedEventsIds.contains(event.id),
                    onTap: () {
                      if (cubit.state.selectedEventsIds.isNotEmpty) {
                        cubit.switchSelectStatus(event.id);
                      } else {
                        cubit.switchEventFavorite(event.id);
                      }
                    },
                    onLongPress: () => 
                      cubit.switchSelectStatus(event.id),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return true;
                    } else if (!cubit.state.isEditMode) {
                      cubit.switchSelectStatus(widget.chatId);
                      cubit.toggleEditMode();
                    }

                    return false;
                  },
                  onDismissed: (_) => cubit.deleteEvent(event.id),
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
      },
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<ChatCubit>().loadChat(widget.chatId);
    context.read<ChatCubit>().updateEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: _createAppBarLeading(context),
          title: _createAppBarTitle(context),
          actions: _createActions(context),
        ),
        body: _createScaffoldBody(context),
      );
    });
  }
}
