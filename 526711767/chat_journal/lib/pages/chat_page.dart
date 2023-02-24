import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/events_tab.dart';
import '../models/message_event.dart';
import '../providers/events_tabs_provider.dart';
import '../theme/custom_theme_inherited.dart';

class ChatPage extends StatefulWidget {
  final EventsTab tab;

  const ChatPage({Key? key, required this.tab}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final EventsTabsProvider _provider = EventsTabsProvider();
  final TextEditingController _controller = TextEditingController();
  final List<MessageEvent> _events = [];
  final List<MessageEvent> _selectedEvents = [];
  MessageEvent? _editedEvent;
  bool _selectionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CustomThemeInherited.of(context).mode.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            CustomThemeInherited.of(context).mode.appBarTheme.backgroundColor,
        title: Text(
          widget.tab.name,
          style: CustomThemeInherited.of(context).mode.textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: [
          if (_selectionMode)
            IconButton(
              onPressed: () {
                _selectedEvents.clear();
                setState(() => _selectionMode = false);
              },
              icon: const Icon(Icons.clear),
            ),
          if (_selectionMode && _selectedEvents.isNotEmpty)
            IconButton(
              onPressed: () {
                for (var x in _selectedEvents) {
                  widget.tab.events.remove(x);
                }
                _selectedEvents.clear();
                setState(() => _selectionMode = false);
              },
              icon: const Icon(Icons.delete),
            ),
          if (_selectionMode && _selectedEvents.length == 1)
            IconButton(
              onPressed: () {
                _editedEvent = _selectedEvents.single;
                _selectedEvents.clear();
                _controller.text = _editedEvent!.text;
                setState(() => _selectionMode = false);
              },
              icon: const Icon(Icons.edit),
            ),
          if (_selectionMode && _selectedEvents.length == 1)
            IconButton(
              onPressed: () async {
                await Clipboard.setData(
                    ClipboardData(text: _selectedEvents.single.text));
                _selectedEvents.clear();
                setState(() => _selectionMode = false);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.tab.events.length,
              itemBuilder: (context, index) =>
                  _message(widget.tab.events[index], context),
              shrinkWrap: true,
            ),
          ),
          if (_editedEvent != null) _editedMessage(),
          _inputRow(context),
        ],
      ),
    );
  }

  Widget _editedMessage() {
    const messageTextStyle = TextStyle(color: Colors.black, fontSize: 20);
    return ColoredBox(
      color: Colors.redAccent,
      child: Row(
        children: [
          const Icon(Icons.edit),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _editedEvent!.text,
              style: messageTextStyle,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _editedEvent = null),
            icon: const Icon(Icons.clear),
          )
        ],
      ),
    );
  }

  Widget _message(MessageEvent event, BuildContext context) {
    const timeTextStyle = TextStyle(color: Colors.blueGrey, fontSize: 14);
    return ColoredBox(
      color: _selectedEvents.contains(event)
          ? Colors.lightBlueAccent
          : Colors.transparent,
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250, minWidth: 100),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectionMode) {
                    if (_selectedEvents.contains(event)) {
                      _selectedEvents.remove(event);
                    } else {
                      _selectedEvents.add(event);
                    }
                  }
                });
              },
              onLongPress: () {
                if (_editedEvent == null) {
                  _selectedEvents.add(event);
                  setState(() => _selectionMode = true);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: CustomThemeInherited.of(context).mode.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        event.text,
                        style: CustomThemeInherited.of(context)
                            .mode
                            .textTheme
                            .headlineMedium,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        DateFormat('Hm').format(event.dateTime),
                        style: timeTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.teal.shade300,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 24),
              controller: _controller,
              decoration: const InputDecoration(
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (_editedEvent == null) {
                setState(() {
                  widget.tab.events.add(
                    MessageEvent(
                      text: _controller.text,
                      dateTime: DateTime.now(),
                    ),
                  );
                  _controller.clear();
                });
              } else {
                setState(() {
                  _editedEvent!.text = _controller.text;
                  _editedEvent = null;
                  _controller.clear();
                });
              }
            },
            child: Icon(
              Icons.send,
              color:
                  CustomThemeInherited.of(context).mode.primaryIconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
