import 'package:chats_repository/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chats/chats.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;

  const ChatPage._({
    super.key,
    required this.chat,
  });

  static Route<void> route({
    Key? key,
    required ChatsCubit chatsCubit,
    required Chat chat,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: chatsCubit,
        child: ChatPage._(
          key: key,
          chat: chat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: ChatView(chat: chat),
    );
  }
}

class ChatView extends StatefulWidget {
  final Chat chat;

  const ChatView({
    super.key,
    required this.chat,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isHasImage(BuildContext context) {
    final chatState = context.read<ChatCubit>().state;
    final events = chatState.chat.events;
    final selectedEvents = chatState.selectedEventsIds;

    return events
        .where(
          (event) => selectedEvents.contains(event.id) && event.isImage,
        )
        .isNotEmpty;
  }

  void _onTap(BuildContext context, String eventId) {
    final chatCubit = context.read<ChatCubit>();
    if (chatCubit.state.selectedEventsIds.isNotEmpty) {
      _onLongPress(context, eventId);
    } else {
      chatCubit.switchEventFavorite(eventId);
    }
  }

  void _onLongPress(BuildContext context, String eventId) {
    context.read<ChatCubit>().switchSelectStatus(eventId);
  }

  void _deleteEvents(BuildContext context) async {
    final chatCubit = context.read<ChatCubit>();
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) =>
          DeleteDialog(chatCubit.state.selectedEventsIds.length),
    );

    if (value == true) {
      chatCubit.deleteSelectedEvents();
    }

    chatCubit.resetSelection();
  }

  void _markFavorites(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    chatCubit.switchSelectedEventsFavorite();
    chatCubit.resetSelection();
  }

  void _copyEvents(BuildContext context) {
    var copyText = '';

    final chatState = context.read<ChatCubit>().state;
    final events = chatState.chat.events;
    final selectedEventsIds = chatState.selectedEventsIds;

    final selectedEvents = events.where(
      (event) => selectedEventsIds.contains(event.id) && !event.isImage,
    );

    for (final event in selectedEvents) {
      copyText += '${event.content}\n';
    }

    Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );

    context.read<ChatCubit>().resetSelection();
  }

  void _transferEvents(BuildContext context) async {
    final chatsCubit = context.read<ChatsCubit>();
    final chatCubit = context.read<ChatCubit>();

    final newChatId = await showDialog<String>(
      context: context,
      builder: (context) => TransferDialog(
          chats: chatsCubit.state.chats
              .where(
                (chat) => chat.id != widget.chat.id,
              )
              .toList()),
    );
    if (newChatId != null) {
      chatsCubit.transferEvents(
        sourceChatId: widget.chat.id,
        destinationChatId: newChatId,
        transferEventsIds: chatCubit.state.selectedEventsIds,
      );
      chatCubit.deleteSelectedEvents();
    }

    chatCubit.resetSelection();
  }

  void _searchEvents(BuildContext context) async {
    await showSearch(
      context: context,
      delegate: EventSearchDelegate(
        events: context.read<ChatCubit>().state.chat.events,
      ),
    );
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
      return Text(widget.chat.name);
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
    final selectedEventsCount =
        context.read<ChatCubit>().state.selectedEventsIds.length;
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () => _transferEvents(context),
      ),
      if (!_isHasImage(context) && selectedEventsCount == 1)
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => context.read<ChatCubit>().toggleEditMode(),
        ),
      if (!_isHasImage(context))
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () => _copyEvents(context),
        ),
      IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: () => _markFavorites(context),
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
      selectedEvent = chatState.chat.events.firstWhere(
        (event) => selectedEvents.contains(event.id),
      );
    }

    return Column(
      children: [
        Expanded(
          child: _createEventsView(),
        ),
        BottomPanel(
          chat: widget.chat,
          sourceEvent: selectedEvent,
        ),
      ],
    );
  }

  List<Event> _generateEventsList(ChatState state) {
    final events = state.chat.events;
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
          previous.chat.events != current.chat.events,
      listener: (context, state) {
        context.read<ChatsCubit>().editChat(
              widget.chat.copyWith(events: state.chat.events),
            );
      },
      builder: (context, state) {
        final events = _generateEventsList(state);

        if (events.isNotEmpty) {
          final chatCubit = context.read<ChatCubit>();

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
                        chatCubit.state.selectedEventsIds.contains(event.id),
                    onTap: () => _onTap(context, event.id),
                    onLongPress: () => _onLongPress(context, event.id),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return true;
                    } else if (!chatCubit.state.isEditMode) {
                      chatCubit.switchSelectStatus(widget.chat.id);
                      chatCubit.toggleEditMode();
                    }

                    return false;
                  },
                  onDismissed: (_) => chatCubit.deleteEvent(event.id),
                );
              });
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: ListTile(
                title: Text(
                  'This is the page where you can track '
                  'everything about "${widget.chat.name}"',
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

    context.read<ChatCubit>().createChat(widget.chat);
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
