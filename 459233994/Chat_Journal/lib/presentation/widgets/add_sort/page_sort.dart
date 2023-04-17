import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../screens/home/home_cubit.dart';
import '../app_theme/inherited_theme.dart';

class PageSort extends StatefulWidget {
  final List<String> excludeChatIds;

  PageSort({required this.excludeChatIds});

  @override
  State<PageSort> createState() => _PageSortState();
}

class _PageSortState extends State<PageSort> {
  late final List<Chat> _chats;
  late final List<bool> _activeChats = [];

  @override
  void initState() {
    super.initState();
    _chats = ReadContext(context).read<HomeCubit>().getChats();
    for (var index = 0; index < _chats.length; index++) {
      _activeChats.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: <Widget>[
          Text(
            'exclude pages',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          Wrap(
            direction: Axis.horizontal,
            children: _chats
                .asMap()
                .map((index, chat) =>
                    MapEntry(index, _chatBubble(chat.name, index)))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _chatBubble(String chatName, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _activeChats[index]
                ? InheritedAppTheme.of(context)!.themeData.actionColor
                : Colors.grey,
          ),
          child: Text(
            chatName,
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
        ),
        onTap: () {
          setState(() {
            _activeChats[index] = !_activeChats[index];
            _activeChats[index]
                ? widget.excludeChatIds.remove(_chats[index].id)
                : widget.excludeChatIds.add(_chats[index].id!);
          });
        },
      ),
    );
  }
}
