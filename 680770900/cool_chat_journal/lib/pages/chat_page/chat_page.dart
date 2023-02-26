import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/chat.dart';
import '../../model/chats_state.dart';
import '../../model/event.dart';
import 'bottom_panel.dart';
import 'delete_dialog.dart';
import 'event_view.dart';

class ChatPage extends StatefulWidget {
  final int chatIndex;

  const ChatPage({required this.chatIndex});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _selectedFlag = <int, bool>{};
  var _showFavorites = false;
  var _isEditMode = false;

  bool _isSelectionMode() => _countSelectedEvents() != 0;
  bool _isHasImage() => _selectedFlag.keys
      .where((key) => _selectedFlag[key] == true)
      .where((key) => _chat.events[key].isImage)
      .isNotEmpty;

  Chat get _chat => context.read<ChatsCubit>().state.chats[widget.chatIndex];

  void _resetSelection() {
    setState(() {
      for (final eventId in _selectedFlag.keys) {
        _selectedFlag[eventId] = false;
      }
    });
  }

  void _onTap(bool isSelected, int index) {
    if (_isSelectionMode()) {
      _onLongPress(isSelected, index);
    } else {
      context.read<ChatsCubit>().markFavoriteEvent(widget.chatIndex, index);
    }
  }

  void _onLongPress(bool isSelected, int index) {
    setState(() {
      _showFavorites = false;
      _selectedFlag[index] = !isSelected;
    });
  }

  void _deleteEvents() async {
    final value = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => DeleteDialog(_countSelectedEvents()),
    );

    if (value == true) {
      final events = _chat.events;
      final deletedEvents = <Event>[];

      for (var i = 0; i < events.length; i++) {
        if (_selectedFlag[i] == true) {
          deletedEvents.add(events[i]);
        }
      }

      for (final deletedEvent in deletedEvents) {
        events.remove(deletedEvent);
      }
    }

    _resetSelection();
  }

  void _markFavorites() {
    for (var i = 0; i < _chat.events.length; i++) {
      if (_selectedFlag[i] == true) {
        context.read<ChatsCubit>().markFavoriteEvent(widget.chatIndex, i);
      }
    }
    
    _resetSelection();
  }

  void _copyEvents() {
    var copyText = '';

    _selectedFlag.keys
        .where((key) =>
            _selectedFlag[key] == true && !_chat.events[key].isImage)
        .map((key) => copyText +=
            copyText.isNotEmpty ? '${_chat.events[key].content}' : '\n');

    Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );

    _resetSelection();
  }

  int _countSelectedEvents() {
    return _selectedFlag.values.where((value) => value).length;
  }

  List<Event> _generateEventsList(ChatsState state) {
    final List<Event> favorites;
    if (_showFavorites) {
      favorites =
        state.chats[widget.chatIndex].events
          .where((event) => event.isFavorite).toList();
    } else {
      favorites = <Event>[];
    }

    final List<Event> events;
    if (favorites.isEmpty) {
      events = state.chats[widget.chatIndex].events;
    } else {
      events = favorites;
    }

    return events.toList();
  }

  Widget _createEventsView() {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final events = _generateEventsList(state);

        if (events.isNotEmpty) {
          return ListView.builder(
            reverse: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final viewIndex = events.length - index - 1;

              _selectedFlag[viewIndex] = _selectedFlag[viewIndex] ?? false;
              final isSelected = _selectedFlag[viewIndex]!;

              return EventView(
                event: events[viewIndex],
                isSelected: isSelected,
                onTap: () => _onTap(isSelected, viewIndex),
                onLongPress: () => _onLongPress(isSelected, viewIndex),
              );
            }
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: _WelcomeMessage(title: _chat.name),
          );
        }
      },
    );
  }

  Widget _createScaffoldBody() {
    var index = _selectedFlag.keys
        .firstWhere((i) => _selectedFlag[i] == true, orElse: () => -1);

    return Column(
      children: [
        Expanded(
          child: _createEventsView(),
        ),
        if (!_isSelectionMode())
        BottomPanel(
          chatIndex: widget.chatIndex,
        ),

        if (_isEditMode && index != -1 && !_chat.events[index].isImage)
          BottomPanel(
            chatIndex: widget.chatIndex,
            resetSelection: () {
              _isEditMode = false;
              _resetSelection();
            },
            textFieldValue: _chat.events[index].content,
            editEventIndex: _selectedFlag.keys.firstWhere(
              (i) => _selectedFlag[i] == true),
          ),
      ],
    );
  }

  Widget _createAppBarLeading() {
    if (_countSelectedEvents() == 0) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    } else if (_isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          _isEditMode = false;
          _resetSelection();
        },
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: _resetSelection,
      );
    }
  }

  Widget _createAppBarTitle() {
    final selectedEvents = _countSelectedEvents();
    if (selectedEvents == 0) {
      return Text(_chat.name);
    } else if (_isEditMode) {
      return const Text('Edit mode');
    } else {
      return Text(selectedEvents.toString());
    }
  }

  List<Widget> _createActionsForNotSelectionMode() {
    final Icon bookmarkIcon;
    if (_showFavorites) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => {},
      ),
      IconButton(
        icon: bookmarkIcon,
        onPressed: () => setState(() => _showFavorites = !_showFavorites),
      ),
    ];
  }

  List<Widget> _createActionsForEditMode() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _isEditMode = false;
          _resetSelection(); 
        },
      ),
    ];
  }

  List<Widget> _createActionsForSelectionMode() {
    final actions = <Widget>[];

    if (!_isHasImage()) {
      actions.addAll([
        if (_countSelectedEvents() == 1)
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => setState(() => _isEditMode = true),
          ),

        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: _copyEvents,
        )
      ]);
    }

    actions.addAll([
      IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: _markFavorites,
      ),

      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: _deleteEvents,
      ),
    ]);

    return actions;
  }

  List<Widget> _createActions() {
    if (_countSelectedEvents() == 0) {
      return _createActionsForNotSelectionMode();
    } else if (_isEditMode) {
      return _createActionsForEditMode();
    } else {
      return _createActionsForSelectionMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _createAppBarLeading(),
        title: _createAppBarTitle(),
        actions: _createActions(),
      ),
      body: _createScaffoldBody(),
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
