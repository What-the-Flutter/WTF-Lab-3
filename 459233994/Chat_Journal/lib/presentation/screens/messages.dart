import 'package:flutter/material.dart';

import '../../domain/entities/packed_message.dart';
import '../widgets/app_theme/app_theme.dart';
import '../widgets/app_theme/inherited_app_theme.dart';
import '../widgets/app_theme/theme.dart';
import '../widgets/messages/messages_bottom_bar.dart';
import '../widgets/messages/messages_list.dart';

class MessagesScreen extends StatefulWidget {
  final String _title;
  late final CustomTheme? _theme;

  MessagesScreen({super.key, required title, required theme})
      : _title = title,
        _theme = theme;

  @override
  State<MessagesScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessagesScreen> {
  final List<PackedMessage> _messages = [];
  bool _favoritesMode = false;
  late final Function _addToMessagesList;
  late final Function _notifyParent;

  _MessageScreenState() {
    _addToMessagesList = _addToMessages;
    _notifyParent = _refresh;
  }

  void _refresh() {
    setState(() {});
  }

  void _addToMessages(PackedMessage message) {
    _messages.add(message);
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      theme: widget._theme,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: InheritedAppTheme.of(context)?.getTheme.keyColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              widget._title,
              style: TextStyle(
                  color: InheritedAppTheme.of(context)?.getTheme.keyColor),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.search,
                  color: InheritedAppTheme.of(context)?.getTheme.keyColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.bookmark_border_outlined,
                  color: InheritedAppTheme.of(context)?.getTheme.keyColor,
                ),
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
          backgroundColor: InheritedAppTheme.of(context)?.getTheme.themeColor,
        ),
        body: SizedBox.expand(
          child: Container(
            color: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
            child: Column(
              children: <Widget>[
                MessagesList(
                  messages: _messages,
                  isFavoritesMode: _favoritesMode,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MessagesBottomBar(
                    addToMessages: _addToMessagesList,
                    notifyParent: _refresh,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
