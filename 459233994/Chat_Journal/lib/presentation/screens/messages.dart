import 'package:flutter/material.dart';

import '../../domain/entities/packed_message.dart';
import '../widgets/messages/inherited_list.dart';
import '../widgets/messages/messages_bottom_bar.dart';
import '../widgets/messages/messages_list.dart';

class MessagesScreen extends StatefulWidget {
  final String _title;

  static InheritedList of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedList>()
          as InheritedList;

  const MessagesScreen({super.key, required title}) : _title = title;

  @override
  State<MessagesScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessagesScreen> {
  final List<PackedMessage> _events = [];
  bool _favoritesMode = false;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InheritedList(
      events: _events,
      favoritesMode: _favoritesMode,
      notifyParent: refresh,
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Center(
              child: Text(widget._title),
            ),
            actions: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  child: Icon(Icons.search),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(Icons.bookmark_border_outlined),
                  onTap: () {
                    setState(() {
                      if (_favoritesMode) {
                        _favoritesMode = false;
                      } else {
                        _favoritesMode = true;
                      }
                    });
                  },
                ),
              ),
            ],
            backgroundColor: const Color(0xffB1CC74),
          ),
          body: Column(
            children: <Widget>[
              MessagesList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: MessagesBottomBar(),
              ),
            ],
          )),
    );
  }
}
