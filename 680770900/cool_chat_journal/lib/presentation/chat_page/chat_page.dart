import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/event.dart';
import '../../data/models/category.dart';
import '../../data/models/chat.dart';
import '../../utils/custom_theme.dart';
import 'chat_cubit.dart';
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
  final _cubit = GetIt.I<ChatCubit>(); 

  late AnimationController _arrowAnimationController;

  late VoidCallback _unsubscribeEventsStream;

  bool _isHasImage({
    required List<Event> events,
    required List<String> selectedEventsIds,
  }) => events
      .where((e) => selectedEventsIds.contains(e.id) && e.image != null)
      .isNotEmpty;

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

  void _onTransferEvents({
    required BuildContext context,
    required List<Chat> chats,
  }) async {
    final destinationChat = await showDialog<String>(
      context: context,
      builder: (_) => 
        TransferDialog(
          chats: chats
              .where((chat) => chat.id != widget.chatId)
              .toList(),
        ),
    );

    if (destinationChat != null) {
      _cubit.transferSelectedEvents(destinationChat);
    }

    _cubit.resetSelection();
  }

  void _onDeleteEvents({
    required BuildContext context,
    required List<String> selectedEventsIds,
  }) async {
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => DeleteDialog(
        countSelectedEvents: selectedEventsIds.length,
      ),
    );

    if (value == true) {
      _cubit.deleteSelectedEvents();
    }

    _cubit.resetSelection();
  }

  Widget _appBarLeading({
    required BuildContext context,
    required List<String> selectedEventsIds,
    required bool isEditMode,
  }) {
    if (selectedEventsIds.isEmpty) {
      return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: Tween<double>(begin: 1.0, end: 0.0)
              .animate(_arrowAnimationController),
        ),
      );
    } else if (isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _cubit.toggleEditMode,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: _cubit.resetSelection,
      );
    }
  }

  Widget _appBarTitle({
    required List<String> selectedEventsIds,
    required bool isEditMode,
  }) {
    if (selectedEventsIds.isEmpty) {
      return Text(widget.chatName ?? 'Timeline');
    } else if (isEditMode) {
      return const Text('Edit mode');
    } else {
      return Text(selectedEventsIds.length.toString());
    }
  }

  
  List<Widget> _actions({
    required BuildContext context,
    required List<String> selectedEventsIds,
    required List<Chat> chats,
    required List<Event> events,
    required bool isFavoriteMode,
    required bool isEditMode,
  }) {
    if (selectedEventsIds.isEmpty) {
      return _actionsForNotSelectionMode(
        context: context,
        events: events,
        isFavoriteMode: isFavoriteMode,
      );
    } else if (isEditMode) {
      return _actionsForEditMode();
    } else {
      return _actionsForSelectionMode(
        context: context,
        selectedEventsIds: selectedEventsIds,
        chats: chats,
        events: events,
      );
    }
  }

  List<Widget> _actionsForNotSelectionMode({
    required BuildContext context,
    required List<Event> events,
    required bool isFavoriteMode,
  }) {
    final Icon bookmarkIcon;
    if (isFavoriteMode) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return <Widget>[
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
    ];
  }

  List<Widget> _actionsForEditMode() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: _cubit.toggleEditMode,
      ),
    ];
  }

  List<Widget> _actionsForSelectionMode({
    required BuildContext context,
    required List<String> selectedEventsIds,
    required List<Chat> chats,
    required List<Event> events,
  }) {
    final isHasImage = _isHasImage(
      events: events, 
      selectedEventsIds: selectedEventsIds
    );

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () => _onTransferEvents(
          context: context,
          chats: chats,
        ),
      ),
      if (!isHasImage && selectedEventsIds.length == 1)
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: _cubit.toggleEditMode,
        ),
      if (!isHasImage)
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            _cubit.copySelectedEvents();
            _cubit.resetSelection();
          },
        ),
      IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: () {
          _cubit.switchSelectedEventsFavorite();
          _cubit.resetSelection();
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _onDeleteEvents(
          context: context,
          selectedEventsIds: selectedEventsIds,
        ),
      ),
    ];
  }

  Widget _scaffoldBody({
    required BuildContext context,
    required List<Event> events,
    required List<Category> categories,
    required List<String> selectedEventsIds,
    required bool isFavoriteMode,
    required bool isEditMode,
  }) {
    final Event? selectedEvent;
    if (selectedEventsIds.length != 1) {
      selectedEvent = null;
    } else {
      selectedEvent = events.firstWhere(
        (event) => selectedEventsIds.contains(event.id),
      );
    }

    final Widget bottomPanel;
    if (widget.chatId != null) {
      bottomPanel = BottomPanel(
        chatId: widget.chatId!,
        sourceEvent: selectedEvent,
      );
    } else {
      bottomPanel = BottomNavigationBar(
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
      );
    }

    return Column(
      children: [
        Expanded(
          child: _eventsView(
            events: events,
            categories: categories,
            selectedEventsIds: selectedEventsIds,
            isFavoriteMode: isFavoriteMode,
            isEditMode: isEditMode,
          ),
        ),
        bottomPanel,
      ],
    );
  }

  List<Event> _eventsList({
    required List<Event> events,
    required bool isFavoriteMode,
  }) {
    final List<Event> favorites;
    if (isFavoriteMode) {
      favorites = events.where((event) => event.isFavorite).toList();

      if (favorites.isNotEmpty) return favorites;
    }

    return events;
  }

  Widget _eventsView({
    required List<Event> events,
    required List<Category> categories,
    required List<String> selectedEventsIds,
    required bool isFavoriteMode,
    required bool isEditMode,
  }) {
    final eventsList = _eventsList(
      events: events,
      isFavoriteMode: isFavoriteMode,
    );

    if (eventsList.isNotEmpty) {
      return ListView.builder(
        reverse: true,
        itemCount: eventsList.length,
        itemBuilder: (_, index) {
          final viewIndex = eventsList.length - index - 1;
          final event = eventsList[viewIndex];

          final Category? category;
          if (event.categoryId != null) {
            category = categories
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
              isSelected: selectedEventsIds.contains(event.id),
              onTap: () {
                if (selectedEventsIds.isNotEmpty) {
                  _cubit.switchSelectStatus(event.id);
                } else {
                  _cubit.switchEventFavorite(event.id);
                }
              },
              onLongPress: () => _cubit.switchSelectStatus(event.id),
            ),
            confirmDismiss: (direction) async {
              if (!isEditMode) {
                _cubit.switchSelectStatus(event.id);
                _cubit.toggleEditMode();
              } else if (direction == DismissDirection.endToStart) {
                return true;
              }

              return false;
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

  @override
  void initState() {
    super.initState();

    _cubit.loadChat(widget.chatId);
    _cubit.subscribeStreams();
    _unsubscribeEventsStream = _cubit.unsubscribeStreams;

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    _unsubscribeEventsStream();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final List<Event> events;
        if (widget.chatId != null) {
          events = 
              state.events.where((e) => e.chatId == widget.chatId!).toList();
        } else {
          events = List<Event>.from(state.events);
        }

        final body = _scaffoldBody(
          context: context,
          events: events,
          categories: state.categories,
          selectedEventsIds: state.selectedEventsIds,
          isFavoriteMode: state.isFavoriteMode,
          isEditMode: state.isEditMode,
        );

        final backgroundImage = CustomTheme.of(context).backgroundImage;
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
            leading: _appBarLeading(
              context: context,
              selectedEventsIds: state.selectedEventsIds,
              isEditMode: state.isEditMode,
            ),
            title: _appBarTitle(
              selectedEventsIds: state.selectedEventsIds,
              isEditMode: state.isEditMode,
            ),
            actions: _actions(
              context: context,
              selectedEventsIds: state.selectedEventsIds,
              chats: widget.chats,
              events: events,
              isFavoriteMode: state.isFavoriteMode,
              isEditMode: state.isEditMode,
            ),
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
